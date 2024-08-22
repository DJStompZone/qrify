import argparse
import qrcode
import sys
import base64

def split_data(data, max_length):
    """
    Splits data into chunks of the specified maximum length.
    
    :param data: The data string to be split.
    :param max_length: The maximum length of each chunk.
    :return: A list of data chunks.
    """
    return [data[i:i + max_length] for i in range(0, len(data), max_length)]

def generate_qr_codes(data_chunks, output_base):
    """
    Generates QR codes from data chunks and saves them as image files.
    
    :param data_chunks: A list of data chunks to be encoded in QR codes.
    :param output_base: The base name for the output QR code image(s).
    """
    for i, chunk in enumerate(data_chunks):
        qr = qrcode.QRCode()
        qr.add_data(chunk)
        qr.make(fit=True)
        img = qr.make_image(fill='black', back_color='white')
        output_filename = f"{output_base}_{i+1}.png" if len(data_chunks) > 1 else f"{output_base}.png"
        img.save(output_filename)
        print(f"Saved: {output_filename}")

def get_output_base(output):
    """
    Determines the base name for the output file(s), discarding any provided extension.
    
    :param output: The provided output base name.
    :return: The base name for the output file(s).
    """
    return output.rsplit('.', 1)[0]

def main():
    """
    Main function to parse arguments and handle QR code generation.
    """
    parser = argparse.ArgumentParser(description="Generate QR code(s) from data.")
    
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--file', type=argparse.FileType('rb'), help="Input file to encode (binary mode)")
    group.add_argument('--raw', type=str, help="Raw data string to encode (as UTF-8)")
    group.add_argument('--stdin', action='store_true', help="Read data from stdin")
    
    parser.add_argument('-o', '--output', type=str, required=True, help="Base name for output QR code image(s)")

    args = parser.parse_args()
    
    if args.file:
        data = args.file.read()
    elif args.raw:
        data = args.raw.encode('utf-8')
    elif args.stdin:
        data = sys.stdin.buffer.read()

    encoded_data = base64.b64encode(data).decode('utf-8')

    max_length = 2331
    
    if len(encoded_data) > max_length:
        data_chunks = split_data(encoded_data, max_length)
    else:
        data_chunks = [encoded_data]
    
    output_base = get_output_base(args.output)
    
    generate_qr_codes(data_chunks, output_base)

if __name__ == "__main__":
    main()
