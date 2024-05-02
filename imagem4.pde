void processar_imagem4(){
  PImage img = loadImage("imagens/img4_original.jpg");
  PImage out = createImage(img.width, img.height, RGB);
  Filtros filt = new Filtros();
  
  out = filt.EscalaCinzaB(img);
  
  out = filt.Brilho(out, 100);
  out.save("imagens/img4_brilho1.png");
  out = filt.BrilhoAlturaY(out, 30, 210);
  out.save("imagens/img4_brilho2.png");
  out = filt.BrilhoAlturaY(out, 50, 315);
  out.save("imagens/img4_brilho3.png");
  float[][] k = {{1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9},
                 {1.0/9,1.0/9,1.0/9}};
  for(int i = 0; i < 35; i++) {
    out = filt.Convolucao(out, k);
  }

  out = filt.Limiarizacao(out, 200, true);

  out = filt.Box(out, 50, 30, 350, 320);
  
  out.save("imagens/img4_gt_gerada.png");
   
  PImage img_ori = loadImage("imagens/img4_gt_original.png");
  println("O total de igualdade da imagem 4 é =", filt.Comparador(out, img_ori),"%");
  
  out = filt.CutGT(img, out);
  out.save("imagens/img4_recortada.png");
}
