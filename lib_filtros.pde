class Filtros {

  Filtros() {
  }
  
  PImage EscalaCinzaMedia(PImage img) {
    PImage out = createImage(img.width, img.height, RGB);
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
        int valor = int((red(img.pixels[pos]) +
                        green(img.pixels[pos]) + 
                        blue(img.pixels[pos]))/3);
        
        out.pixels[pos] = color(valor);
      }
    }
    return out;
  }
  
  PImage EscalaCinzaR(PImage img) {
    PImage out = createImage(img.width, img.height, RGB);
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
        int valor = int(red(img.pixels[pos]));

        out.pixels[pos] = color(valor);
      }
    }
    return out;
  }
  
  PImage EscalaCinzaG(PImage img) {
    PImage out = createImage(img.width, img.height, RGB);
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
        int valor = int(green(img.pixels[pos]));

        out.pixels[pos] = color(valor);
      }
    }
    return out;
  }
  
  PImage EscalaCinzaB(PImage img) {
    PImage out = createImage(img.width, img.height, RGB);
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
        int valor = int(blue(img.pixels[pos]));

        out.pixels[pos] = color(valor);
      }
    }
    return out;
  }
  
  PImage Convolucao(PImage img, float[][] k) {
    PImage out = createImage(img.width, img.height, RGB);

    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int jan = 1;
        int pos = y*img.width + x;
        Float media = 0.0;
  
        for (int i = jan*(-1); i <= jan; i++) {
          for (int j = jan*(-1); j <= jan; j++) {
            int ny = y+i;
            int nx = x+j;
            if (ny >= 0 && ny < img.height &&
              nx >= 0 && nx < img.width) {
              int pos_aux = ny * img.width + nx;
              media += red(img.pixels[pos_aux]) * k[i+1][j+1];
            }
          }
        }
        out.pixels[pos] = color(media);
      }
    }
    return out;
  }
  
  PImage Sobel(PImage img) {
    PImage out = createImage(img.width, img.height, RGB);
    int[][] gx = {{-1,-2,-1},{0,0,0},{1,2,1}};
    int[][] gy = {{-1,0,1},{-2,0,2}, {-1,0,1}};
  
    // Filtro de Borda - Sobel
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int jan = 1;
        int pos = (y)*img.width + (x);
  
        float mediaOx = 0, mediaOy = 0;

        for (int i = jan*(-1); i <= jan; i++) {
          for (int j = jan*(-1); j <= jan; j++) {
            int disy = y+i;
            int disx = x+j;
            if (disy >= 0 && disy < img.height &&
              disx >= 0 && disx < img.width) {
              int pos_aux = disy * img.width + disx;
              float Ox = red(img.pixels[pos_aux]) * gx[i+1][j+1];
              float Oy = red(img.pixels[pos_aux]) * gy[i+1][j+1];
              mediaOx += Ox;
              mediaOy += Oy;
            }
          }
        }
  
        float mediaFinal = sqrt(mediaOx*mediaOx + mediaOy*mediaOy);

        if (mediaFinal > 255) mediaFinal = 255;
        if (mediaFinal < 0) mediaFinal = 0;
  
        out.pixels[pos] = color(mediaFinal);
      }
    }
    return out;
  }
  
  PImage Brilho(PImage img, int limiar){
    PImage out = createImage(img.width, img.height, RGB);
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y*img.width + x;
        int valor = (int) red(img.pixels[pos]);
        valor += limiar;
        if(valor > 255) valor = 255;
        out.pixels[pos] = color(valor);
      }
    }
    return out;
  }

  PImage BrilhoAlturaY(PImage img, int limiar, int alturay){
    PImage out = createImage(img.width, img.height, RGB);
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y*img.width + x;
        // Verifica se Y é maior ou igual a 100
        if (y >= alturay) {
          int valor = (int)blue(img.pixels[pos]);
          valor += limiar;
          valor = constrain(valor, 0, 255); // Limita o valor entre 0 e 255
          out.pixels[pos] = color(valor); // Usa valor direto, pois já está no intervalo correto
        }
        else{
          out.pixels[pos] = color((int)blue(img.pixels[pos]));
          
          }
      }
    }
    return out;
  }
  
  PImage Contraste(PImage img, float limiar){
    PImage out = createImage(img.width, img.height, RGB);
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y*img.width + x;
        int valor = (int) red(img.pixels[pos]);
        valor = int(valor * limiar);
        if(valor > 255) valor = 255;
        out.pixels[pos] = color(valor);
      }
    }
    return out;
  }
  
  PImage PassaBaixaRGB(PImage img, int r, int g, int b){
    PImage out = createImage(img.width, img.height, RGB);
    
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
  
        if(red(img.pixels[pos]) < r &&
           green(img.pixels[pos]) < g &&
           blue(img.pixels[pos]) < b){
          out.pixels[pos] = color(255);
        } else {
          out.pixels[pos] = color(red(img.pixels[pos]), green(img.pixels[pos]), blue(img.pixels[pos]));
        }
      }
    }
    return out;
  }
  
  PImage PassaAltaRGB(PImage img, int r, int g, int b){
    PImage out = createImage(img.width, img.height, RGB);
    
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
  
        if(red(img.pixels[pos]) > r &&
           green(img.pixels[pos]) > g &&
           blue(img.pixels[pos]) > b){
          out.pixels[pos] = color(0);
        } else {
          out.pixels[pos] = color(red(img.pixels[pos]), green(img.pixels[pos]), blue(img.pixels[pos]));
        }
      }
    }
    return out;
  }
  
  PImage Box(PImage img, int x1, int y1, int x2, int y2){
    PImage out = createImage(img.width, img.height, RGB);
  
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
        
        int valor = int(red(img.pixels[pos]));
        
        if (valor == 255 && x >= x1 && x <= x2 && y >= y1 && y <= y2) valor = 255;
        else valor = 0;
        
        out.pixels[pos] = color(valor);
      }
    }
    
    return out;
  }
  
  PImage BoxInterno(PImage img, int x1, int y1, int x2, int y2){
    PImage out = createImage(img.width, img.height, RGB);
  
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
        
        int valor = int(red(img.pixels[pos]));
        
        if (x <= x1 || x >= x2 || y <= y1 || y >= y2) valor = 255;
        
        out.pixels[pos] = color(valor);
      }
    }
    
    return out;
  }
  
  PImage Soma(PImage img1, PImage img2){
    PImage out = createImage(img1.width, img1.height, RGB);
    float[][] values = new float [img1.width][img1.height];
    
    for (int y = 0; y < img1.height; y++) {
      for (int x = 0; x < img1.width; x++) {
        int pos = y*img1.width + x;
  
        values[x][y] = (red(img1.pixels[pos]) + red(img2.pixels[pos]));
      }
    }
    
    float maior = values[0][0];
    float menor = values[0][0];
  
    for (int y = 0; y < img1.height; y++) {
      for (int x = 0; x < img1.width; x++) {
        if (values[x][y] > maior) {
          maior = values[x][y];
        } else if (values[x][y] < menor) {
          menor = values[x][y];
        }
      }
    }
    
    for (int y = 0; y < out.height; y++) {
      for (int x = 0; x < out.width; x++) {
        int pos = y * out.width + x;
        int valor = (int) map(values[x][y], menor, maior, 0, 255);
        out.pixels[pos] = color(valor);
      }
    }
    return out;
  }

  PImage Limiarizacao(PImage img, int limiar, boolean invert) {
    PImage out = createImage(img.width, img.height, RGB);
  
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
        
        int valor = int(red(img.pixels[pos]));
        
        if (invert){
          if (valor < limiar) valor = 255;
          else valor = 0;
        } else {
          if (valor >= limiar) valor = 255;
          else valor = 0; 
        }
        
        out.pixels[pos] = color(valor);
      }
    }
    return out;
  }
  
  float Comparador(PImage img1, PImage img2){
    int total = 0;
  
    for (int y = 0; y < img1.height; y++) {
      for (int x = 0; x < img1.width; x++) {
        int pos = y * img1.width + x;
        
        if ((red(img1.pixels[pos]) > 127 && red(img2.pixels[pos]) > 127) ||
            (red(img1.pixels[pos]) < 127 && red(img2.pixels[pos]) < 127)){
          total += 1;
        }
      }
    }
    return (((float)total/(img1.height*img1.width))*100);
  }
  
  PImage CutGT(PImage img, PImage gt){
    PImage out = createImage(img.width, img.height, RGB);
  
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
        int pos = y * img.width + x;
        
        if (red(gt.pixels[pos]) > 100) {
          out.pixels[pos] = color(red(img.pixels[pos]), green(img.pixels[pos]), blue(img.pixels[pos]));
        } else {
          out.pixels[pos] = color(0);
        }
      }
    }
    return out;
  }
  
}
