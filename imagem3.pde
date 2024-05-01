void processar_imagem3(){
  PImage img = loadImage("imagens/img3_original.jpg");
  PImage out = createImage(img.width, img.height, RGB);

  Filtros filt = new Filtros();

  out = filt.PassaBaixaRGB(img, 80, 80, 80);
  out.save("imagens/img3_passa_baixa.png");
  out = filt.EscalaCinzaB(out);
  out.save("imagens/img3_EscalaCinzaB.png");

  float[][] k = {{1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9}};
  for(int i = 0; i < 2; i++) {
    out = filt.Convolucao(out, k);
  }
  
  out = filt.Brilho(out, 100);
  out.save("imagens/img3_FiltroBrilho.png");
  
  out = filt.Limiarizacao(out, 210, true);
  out.save("imagens/img3_gt_gerada.png");

  PImage img_ori = loadImage("imagens/img3_gt_original.png");
  println("O total de igualdade da imagem 3 é =", filt.Comparador(out, img_ori),"%");
}
