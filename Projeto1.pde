void setup() {
  size(400, 400);
  noLoop();
  background(255);
}

void draw() {
  PImage img = createImage(width, height, RGB);
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color(255); 
  }
  
  processar_imagem1();
  image(img, 0 ,0);
  processar_imagem2();
  image(img, 0 ,0);
  processar_imagem3();
  image(img, 0 ,0);
  processar_imagem4();
  image(img, 0 ,0);
  processar_imagem5();
}
