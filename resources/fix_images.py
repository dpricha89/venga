import requests
import os
import json
import shutil
from PIL import Image
from resizeimage import resizeimage
import time

basePath = os.path.dirname(os.path.realpath(__file__))
experiencePath = "%s/data/experiences" % basePath
imagesPath = "%s/images" % basePath
base_s3_Path = 'https://s3-us-west-2.amazonaws.com/venga-static/dev-images/'

for filename in os.listdir(experiencePath):
    fullExperiencePath = "{}/{}".format(experiencePath, filename)
    print("Reading file {}".format(fullExperiencePath))
    experience = file(fullExperiencePath).read()
    experienceArray = json.loads(experience)
    for experienceDict in experienceArray:
        for index, image in enumerate(experienceDict["images"]):
            r = requests.get(image["url"], stream=True)
            if r.status_code == 200:
                with open("{}/images/{}-{}.jpeg".format(basePath, experienceDict["id"], index), 'wb') as out_file:
                    shutil.copyfileobj(r.raw, out_file)
            del r
            with open("{}/images/{}-{}.jpeg".format(basePath, experienceDict["id"], index), 'r+b') as f:
                with Image.open(f) as image:
                    print(experienceDict["title"])
                    cover = resizeimage.resize_cover(image, [414, 260])
                    cover.save("{}/images-resized/{}-{}.jpeg".format(basePath,
                                                                     experienceDict["id"], index), image.format)

    time.sleep(5)
