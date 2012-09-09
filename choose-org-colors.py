
  """
  Interpolate eight colors between two limits
  """
  from grapefruit import Color
  import numpy as np
  import sys
  try: 
      spec1, spec2 = sys.argv[1:3]
      color1 = Color.NewFromHtml(spec1)
      color2 = Color.NewFromHtml(spec2)
  except: 
      print """
  Usage: %s spec1 spec2
  
  Where spec1 and spec2 are valid HTML color specs
  """ % (sys.argv[0])
  
  NCOLORS = 8
  fracs = np.linspace(1.0, 0.0, NCOLORS)
  colors = [color1.Blend(color2, frac) for frac in fracs]
  
  facespec="'(org-level-%i ((((class color) (background dark)) (:foreground \"%s\"))))"
  print ";; %s to %s" % (spec1, spec2)
  for i, c in enumerate(colors):
      print facespec % (i+1, c.html)
  print
  
