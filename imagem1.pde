void processar_imagem1() {
  PImage img = loadImage("imagens/img1_original.jpg");
  PImage out = createImage(img.width, img.height, RGB);
  Filtros filt = new Filtros();
  
  PImage out1 = createImage(img.width, img.height, RGB);
  out1 = filt.EscalaCinzaR(img);

  out1 = filt.Contraste(out1, 1.5);
  
  float[][] k = {{1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9}};
  for(int i = 0; i < 2; i++) {
    out1 = filt.Convolucao(out1, k);
  }

  out1 = filt.Limiarizacao(out1, 200, false);
  out1 = filt.Box(out1, 65, 120, 260, 300);
  out1.save("imagens/img1_parte1.png");
  
  PImage out2 = createImage(img.width, img.height, RGB);
  out2 = filt.EscalaCinzaB(img);

  out2 = filt.Brilho(out2, 20);
  out2 = filt.Contraste(out2, 1.5);

  for(int i = 0; i < 5; i++) {
    out2 = filt.Convolucao(out2, k);
  }

  out2 = filt.Limiarizacao(out2, 130, true);
  out2 = filt.Box(out2, 120, 115, 220, 230);
  out2.save("imagens/img1_parte2.png");
  
  out = filt.Soma(out1, out2);
  out.save("imagens/img1_soma.png");
  out = filt.Limiarizacao(out, 10, false);
  out.save("imagens/img1_gt_gerada.png");
   
  PImage img_ori = loadImage("imagens/img1_gt_original.png");
  println("O total de igualdade da imagem 1 é =", filt.Comparador(out, img_ori),"%");
  
  out = filt.CutGT(img, out);
  out.save("imagens/img1_recortada.png");
}
