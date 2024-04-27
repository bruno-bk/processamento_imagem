void processar_imagem2(){
  PImage img = loadImage("imagens/img2_original.jpg");
  PImage out = createImage(img.width, img.height, RGB);
  Filtros filt = new Filtros();
  
  PImage out1 = createImage(img.width, img.height, RGB);
  out1 = filt.PassaBaixaRGB(img, 50, 50, 50);
  out1 = filt.EscalaCinzaB(img);
  
  out1 = filt.Brilho(out1, 30);
  out1 = filt.Contraste(out1, 1.8);

  float[][] k = {{1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9}};
  for(int i = 0; i < 5; i++) {
    out1 = filt.Convolucao(out1, k);
  }
  
  out1 = filt.BoxInterno(out1, 70, 3, 380, 300);

  out1 = filt.Limiarizacao(out1, 160, true);
  image(out1, 0 ,0);
  save("imagens/img2_parte1.png");

  PImage out2 = createImage(img.width, img.height, RGB);
  out2 = filt.PassaBaixaRGB(img, 240, 160, 240);
  out2 = filt.EscalaCinzaMedia(out2);

  for(int i = 0; i < 35; i++) {
    out2 = filt.Convolucao(out2, k);
  }
  out2 = filt.BoxInterno(out2, 90, 55, 325, 292);

  out2 = filt.Limiarizacao(out2, 225, true);
  image(out2, 0 ,0);
  save("imagens/img2_parte2.png");

  out = filt.Soma(out1, out2);
  out = filt.Limiarizacao(out, 10, false);
  image(out, 0 ,0);
  save("imagens/img2_gt_gerada.png");

  PImage img_ori = loadImage("imagens/img2_gt_original.png");
  println("O total de igualdade da imagem 2 é =", filt.Comparador(out, img_ori),"%");
}
