void processar_imagem2(){
  // Carregando a imagem original
  PImage img = loadImage("imagens/img3_original.jpg");
  
  // Criando uma imagem para cada etapa do processamento
  PImage out1 = createImage(img.width, img.height, RGB);
  PImage out2 = createImage(img.width, img.height, RGB);
  PImage out = createImage(img.width, img.height, RGB);
  
  // Criando uma instância da classe Filtros
  Filtros filt = new Filtros();
  
  // Aplicando o filtro Passa-Baixa RGB e Escala de Cinza
  out1 = filt.PassaBaixaRGB(img, 50, 50, 50);
  out1 = filt.EscalaCinzaB(out1);
  
  // Aplicando brilho e contraste na primeira parte da imagem
  out1 = filt.Brilho(out1, 30);
  out1 = filt.Contraste(out1, 1.8);

  // Criando o kernel para o filtro de média
  float[][] k = {{1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9}};
                 
  // Aplicando o filtro de média várias vezes
  for(int i = 0; i < 5; i++) {
    out1 = filt.Convolucao(out1, k);
  }
  
  // Aplicando o filtro Box Interno na primeira parte da imagem
  out1 = filt.BoxInterno(out1, 70, 3, 380, 300);

  // Aplicando a limiarização na primeira parte da imagem
  out1 = filt.Limiarizacao(out1, 160, true);
  
  // Salvando a primeira parte da imagem
  out1.save("imagens/img3_parte1.png");
  
  // Aplicando o filtro Passa-Baixa RGB e Escala de Cinza na segunda parte da imagem
  out2 = filt.PassaBaixaRGB(img, 240, 160, 240);
  out2 = filt.EscalaCinzaMedia(out2);

  // Aplicando o filtro de média várias vezes na segunda parte da imagem
  for(int i = 0; i < 35; i++) {
    out2 = filt.Convolucao(out2, k);
  }
  
  // Aplicando o filtro Box Interno na segunda parte da imagem
  out2 = filt.BoxInterno(out2, 90, 55, 325, 292);

  // Aplicando a limiarização na segunda parte da imagem
  out2 = filt.Limiarizacao(out2, 225, true);
  
  // Salvando a segunda parte da imagem
  out2.save("imagens/img3_parte2.png");

  // Somando as duas partes da imagem
  out = filt.Soma(out1, out2);
  
  // Aplicando limiarização na imagem final
  out = filt.Limiarizacao(out, 10, false);
  
  // Salvando a imagem final
  out.save("imagens/img3_gt_gerada.png");

  // Carregando a imagem original para comparação
  PImage img_ori = loadImage("imagens/img3_gt_original.png");
  
  // Calculando a porcentagem de igualdade entre a imagem gerada e a imagem original
  println("O total de igualdade da imagem 3 é =", filt.Comparador(out, img_ori),"%");
}
