// The function atan2(y, x) computes the angle θ (in radians) between the positive x-axis and the point (x, y) in a 2D Cartesian coordinate system. It returns the correct angle in all four quadrants, unlike atan(y/x), which only works for quadrants I & IV.
// Example: atan2[ 1;  1]   / Expected:  0.7854 (π/4, Quadrant I) 
atan2:{[y; x]
  pi: 3.141592653589793;
  / Handle special cases when x = 0
  if[x=0; : (y>0) * pi%2 + (y<0) * ((neg pi)%2)];
  / Compute atan(y/x)
  theta: atan[y%x];
  / Adjust quadrant
  if[x<0; theta+: pi * (1 - 2 * (y<0))];
  theta
 };


// Function to compute distance between two lat/lon points in km
// haversine[37.7749; -122.4194; 34.0522; -118.2437]
haversine:{[lat1; lon1; lat2; lon2]
  R: 6371.0; / Earth's radius in km (double-checking precision)

  degToRad: {x * 0.0174532925199433};  / More precise radian conversion
  lat1: degToRad lat1;
  lon1: degToRad lon1;
  lat2: degToRad lat2;
  lon2: degToRad lon2;

  dlat: lat2 - lat1;
  dlon: lon2 - lon1;

  a: sin[dlat % 2] * sin[dlat % 2] + cos[lat1] * cos[lat2] * sin[dlon % 2] * sin[dlon % 2];
  c: 2 * atan2Manual[sqrt a; sqrt[1-a]]; / Quadrant-corrected atan2

  R * c
 };


// The midpoint formula calculates the geographical center between two latitude-longitude points. This is useful for navigation and spatial analysis.
// midpoint[37.7749; -122.4194; 34.0522; -118.2437]
midpoint:{[lat1; lon1; lat2; lon2]
    lat1:lat1*acos -1%180;  / Convert to radians
    lon1:lon1*acos -1%180;
    lat2:lat2*acos -1%180;
    lon2:lon2*acos -1%180;

    dlon: lon2 - lon1;
  
    B: cos[lat2] * cos[dlon];
    C: cos[lat2] * sin[dlon];

    latM: atan[(sin[lat1] + sin[lat2]) % sqrt[(cos[lat1] + B) * (cos[lat1] + B) + C * C]];
    lonM: lon1 + atan2[C; cos[lat1] + B];

    : (latM * 180 % acos -1; lonM * 180 % acos -1)  / Convert back to degrees
 };