#!/bin/env python

import yaml

import sys
images = set()

def get_all_images(yaml_dict):
    for key, value in yaml_dict.items():
        if isinstance(value, dict):
            get_all_images(value)
        elif isinstance(value, list):
            for item in value:
                if isinstance(item, dict):
                    get_all_images(item)
        elif isinstance(key, str) and key == "image":
            images.add(value)

yaml_file = "calico.yaml"  # 你可以修改为你的YAML文件路径
yaml_file = sys.argv[1]

with open(yaml_file, 'r', encoding='utf-8') as file:
    all_docs_generator = yaml.load_all(file, Loader=yaml.FullLoader)
    for data in all_docs_generator:
        get_all_images(data)

for img in images:
    print(img)

