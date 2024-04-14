import argparse
import secrets
import string

SIMPLE_SYMBOLS = ".,!?"

def generate_password(length: int, simple_symbols: bool):
    lowercase_letters = string.ascii_lowercase
    uppercase_letters = string.ascii_uppercase
    digits = string.digits
    symbols = string.punctuation
    if simple_symbols:
        symbols = SIMPLE_SYMBOLS
    char_sets = [lowercase_letters, uppercase_letters, digits, symbols]
        
    all_characters = lowercase_letters + uppercase_letters + digits + symbols

    password = ''.join(secrets.choice(all_characters) for _ in range(length))
    
    final_password = ""
    while password != final_password:
        final_password = password
        for char_set in char_sets:
            password = add_if_not_contains(password, char_set)
        
    return password

def add_if_not_contains(password: str, char_set: str):
    if not contains(password, char_set):
        password = replace(password, char_set)
    return password

def contains(password: str, char_set: str):
    return any(letter in char_set for letter in password)

def replace(password: str, char_set: str):
    password = list(password)
    password[secrets.choice(range(len(password)))] = secrets.choice(char_set)
    return ''.join(password)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate a secure password')
    parser.add_argument('-l', '--length', type=int, default=12, help='Length of the password (default: 12)')
    parser.add_argument('-c', '--complex-symbols', action="store_false", help=f'Simple symbols are just {SIMPLE_SYMBOLS!r} (default: True)')
    args = parser.parse_args()

    secure_password = generate_password(args.length, args.complex_symbols)
    print(secure_password)
