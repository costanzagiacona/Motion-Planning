void forma(int nfigura, boolean flag) //input -> numero figura, false se spazio operativo
  //                         vero se ostacoli
{
  //colore figura
  fill(#9B6F40);
  stroke(0);
  //scegli la figura in base al numero
  switch(nfigura)
  {
  case 1:
    //quadrato
    //box(200+incr, 200+incr, 10); //lunghezza,altezza,profondità
    figura(4, 400,400);
    break;

  case 2:
    //rettangolo
    //box(60+incr, 40+incr, 10); //lunghezza,altezza,profondità
    figura(4,300,100);
    break;

  case 3:
    //rombo
    figura(4, 50, 10); //sides, lato1,lato2
    break;

  case 4:
    //cerchio
    figura(40, 30, 30); //sides, lato1,lato2

    break;

  case 5:
    //triangolo
    figura(3, 30, 30); //sides, lato1,lato2
    break;

  case 6:
    //trapezio
    trapezio(30+incr,50+incr,80+incr,50+incr);
    break;

  default:
    break;
  }

  //scegli la dimensione
}



//disegna rombo, il cilindro e il triangolo
void figura(int sides, int lato1, int lato2)
{
  /*Calcola l'angolo in radianti per ogni lato del rombo.
   Divide 360 gradi per il numero di lati per ottenere l'angolo.*/
  //sides->numero segmenti
  float angle = 360 / sides;


  // Disegna la figura in alto
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos(radians(i * angle)) * (lato1+incr);
    float y = sin(radians(i * angle)) * (lato2+incr);
    vertex(x, y, 10);
  }
  endShape(CLOSE);

  // Disegna l figura in basso
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos(radians(i * angle)) * (lato1+incr);
    float y = sin(radians(i * angle)) * (lato2+incr);
    vertex(x, y, -10);
  }
  endShape(CLOSE);

  // disegna il corpo
  beginShape(TRIANGLE_STRIP);
  /*genera una serie di vertici lungo la circonferenza del rombo sia nella parte superiore
   che inferiore,collegandoli per formare una serie di triangoli.
   Questo crea l'effetto di un rombo pieno*/

  for (int i = 0; i < sides + 1; i++)
  {
    float x = cos( radians( i * angle ) ) * (lato1+incr);
    float y = sin( radians( i * angle ) ) * (lato2+incr);
    vertex( x, y, 10);
    vertex( x, y, -10);
  }
  endShape(CLOSE);
}

//primo vertice 
//secondo vertice 
void trapezio(float x1, float y1, float x2, float y2)  // input -> coordinate vertici
{
  int n = 11;
  for (int i = 0; i < n; i++) 
  {
    //disegna i vertici in senso antiorario
    beginShape();
    //simmetrico rispetto all'origine-> stessa x ma cambiata di segno
    vertex(x1, -y1, i); //in alto a dx
    vertex(-x1, -y1, i); //in alto a sx
    //simmetrico rispetto all'origine-> stessa x ma cambiata di segno
    vertex(-x2, y2, i); //in basso a sx
    vertex(x2, y2, i); //in basso a dx
    endShape(CLOSE);
  }
}
