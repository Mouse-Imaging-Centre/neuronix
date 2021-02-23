import os

import nibabel as nib

img = nib.load(os.getenv("infile"))
with open(os.getenv("out"), 'w') as f:
  f.write(str(min(img.header.get_zooms())))
