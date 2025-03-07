import yaml

with open('config.yml', 'r') as file
    data = yaml.safe_load(file)
    print(data)
