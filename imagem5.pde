void processar_imagem5() {
  PImage img = loadImage("imagens/img5_original.jpg");
  PImage out = createImage(img.width, img.height, RGB);
  Filtros filt = new Filtros();
  
 out = filt.EscalaCinzaG(img);
 out.save("imagens/img5_escala1.jpg");

 //out = filt.Brilho(out, 0);
  //out.save("imagens/img5_brilho1.jpg");
  out = filt.BrilhoAlturaY(out, 125, 245);
  out.save("imagens/img5_brilho2.png");
  
  out = filt.Limiarizacao(out, 180, true);
  out.save("imagens/img5_limiarizacao3.jpg");
   
  PImage img_ori = loadImage("imagens/img5_gt_original.png");
  println("O total de igualdade da imagem 5 é =", filt.Comparador(out, img_ori),"%");
  
  out = filt.CutGT(img, out);
  out.save("imagens/img5_recortada.png");
}
