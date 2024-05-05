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
  processar_imagem2();
  processar_imagem3();
  processar_imagem4();
  processar_imagem5();
}
