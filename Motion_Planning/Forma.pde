void forma(int nfigura, boolean flag) //input -> numero figura, false se spazio operativo
                                      //                         vero se ostacoli
{
  //colore figura
  fill(255,0,0);
  //scegli la figura in base al numero
  switch(nfigura)
  {
    case 1:
      //quadrato
       box(30);
      
    case 2:
      //rettangolo
      box(60,60,10); //lunghezza,altezza,profondità
      
    case 3:
      //rombo
      rombo(50);
      
     case 4:
     //cerchio
     
     case 5:
     //triangolo
     
     case 6:
     //trapezio
     
     default:
     break;
  }
  
  //scegli la dimensione
  
}

void rombo(float lato)  // input -> lunghezza del lato del rombo
{
  float diagonale1 = lato / sqrt(2);  // Calcola la lunghezza di una diagonale
  //float diagonale2 = lato / sqrt(2);  // Calcola la lunghezza dell'altra diagonale

  // Calcola le coordinate dei vertici del rombo
  float x1 = width/2 - diagonale1/2;
  float y1 = height/2;

  float x2 = width/2;
  float y2 = height/2 - lato/2;

  float x3 = width/2 + diagonale1/2;
  float y3 = height/2;

  float x4 = width/2;
  float y4 = height/2 + lato/2;

  // Disegna il rombo
  beginShape();
  vertex(x1, y1);
  vertex(x2, y2);
  vertex(x3, y3);
  vertex(x4, y4);
  endShape(CLOSE);
}
