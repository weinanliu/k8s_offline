#!/bin/env python
import re

registry_placement = {
    "docker.elastic.co": "elastic.m.daocloud.io",
"docker.io": "docker.m.daocloud.io",
"gcr.io": "gcr.m.daocloud.io",
"ghcr.io": "ghcr.m.daocloud.io",
"k8s.gcr.io": "k8s-gcr.m.daocloud.io",
"registry.k8s.io": "k8s.m.daocloud.io",
"mcr.microsoft.com": "mcr.m.daocloud.io",
"nvcr.io": "nvcr.m.daocloud.io",
"quay.io": "quay.m.daocloud.io",
"registry.ollama.ai": "ollama.m.daocloud.io",
}

import sys
import subprocess
images__input = sys.argv[1:-1]
dest_tar = sys.argv[-1]

def placement_registry(images):
    images_after_placement = []
    for img in images:
        ok = False
        for orig, dest in registry_placement.items():
            if img.startswith(orig):
                images_after_placement.append(img.replace(orig, dest))
                ok = True
                break
        if not ok:
            images_after_placement.append(img)
    return images_after_placement

def pull_images(images, namespace="k8s.io"):
    for img in images:
        cmd = ['ctr', '-n', namespace, 'image', 'pull', '--all-platforms', img]
        print(cmd)
        subprocess.run(cmd, check=True)

def retag(images, after_tag, namespace="k8s.io"):
    for img, taged_img in zip(images, after_tag):
        cmd = ['ctr', '-n', namespace, 'image', 'tag', img, taged_img]
        print(cmd)
        subprocess.run(cmd, check=True)

def export_images(images, dest_tar, namespace="k8s.io"):
    cmd = ['ctr', '-n', namespace, 'image', 'export', '--all-platforms'] + [dest_tar] + images
    print(cmd)
    subprocess.run(cmd, check=True)

after_placement = placement_registry(images__input)
print(after_placement)
pull_images(after_placement)
retag(after_placement, images__input)
export_images(images__input, dest_tar)
