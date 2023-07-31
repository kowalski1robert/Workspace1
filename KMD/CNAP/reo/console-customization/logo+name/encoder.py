import base64

with open("logoKMD60pxblack.png", "rb") as image_file:
    encoded_string = base64.b64encode(image_file.read())

    with open("encodedlogoblack", "wb") as encoded_file:
        encoded_file.write(encoded_string)
