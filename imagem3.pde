void processar_imagem3() {
  PImage img = loadImage("img3_original.jpg");
  PImage out = createImage(img.width, img.height, RGB);
  Filtros filt = new Filtros();
  
  PImage out1 = createImage(img.width, img.height, RGB);
  out1 = filt.PassaBaixaRGB(img, 80, 80, 80);
  
  // Convertendo para escala de cinza
  out1 = filt.EscalaCinzaB(out1);
  
  // Aplicando brilho e contraste
  out1 = filt.Brilho(out1, 100);
  out1 = filt.Contraste(out1, 1.0);
  
  // Aplicando filtro de média
  float[][] kernelMedia = {{1.0/9, 1.0/9, 1.0/9},
                           {1.0/9, 1.0/9, 1.0/9},
                           {1.0/9, 1.0/9, 1.0/9}};
  for (int i = 0; i < 4; i++) {
    out1 = filt.Convolucao(out1, kernelMedia);
  }
  
  // Aplicando limiarização
  out1 = filt.Limiarizacao(out1, 210, true);
  
  // Salvando a parte processada da imagem 3
  out1.save("imagens/img3_parte1.png");
  
  PImage out2 = createImage(img.width, img.height, RGB);
  out2 = filt.PassaBaixaRGB(img, 240, 160, 240);
  out2 = filt.EscalaCinzaMedia(out2);

  // Mais iterações de convolução
  for(int i = 0; i < 35; i++) {
    out2 = filt.Convolucao(out2, kernelMedia);
  }
  
  // Aplicando limiarização
  out2 = filt.Limiarizacao(out2, 225, true);
  
  // Salvando a parte processada da imagem 3
  out2.save("imagens/img3_parte2.png");
  
  // Combinando as partes processadas
  out = filt.Soma(out1, out2);
  
  // Aplicando limiarização final
  out = filt.Limiarizacao(out, 10, false);
  
  // Salvando a imagem final
  out.save("imagens/img3_gt_gerada.png");
  
  PImage img_ori = loadImage("imagens/img3_gt_original.png");
  println("O total de igualdade da imagem 3 é =", filt.Comparador(out, img_ori),"%");
}
