import base64

with open("kmdNecNeg100px.svg", "rb") as image_file:
    encoded_string = base64.b64encode(image_file.read())

    with open("encodedlogo100svg", "wb") as encoded_file:
        encoded_file.write(encoded_string)
