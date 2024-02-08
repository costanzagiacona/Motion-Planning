//SPAZIO OPERATIVO
//scegli la figura in base al numero
void formasp(int nfigura) //input -> numero figura
{
  //colore figura
  fill(#9B6F40);
  // bordo della figura di colore nero
  stroke(0);

  switch(nfigura)
  {
  case 1:
    //quadrato
    figura(4, 500, 500,incrsp);
    posxsp[0] = 500+incrsp;
    posysp[0] = 500+incrsp;
    rotateZ(-PI/4);
    break;

  case 2:
    //rettangolo
    figura(4, 480, 550,incrsp);
    posxsp[1] = 480+incrsp;
    posysp[1] = 550+incrsp;
    break;

  case 3:
    //rombo
    figura(4, 550, 150,incrsp); //sides, lato1, lato2, incr
    posxsp[2] = 550+incrsp;
    posysp[2] = 150+incrsp;
    break;

  case 4:
    //cerchio
    figura(30, 400, 400,incrsp); //sides, lato1, lato2
    posxsp[3] = 400+incrsp;
    posysp[3] = 400+incrsp;
    break;

  case 5:
    //triangolo
    figura(3, 500, 500,incrsp); //sides, lato1, lato2
    posxsp[4] = 500+incrsp;
    posysp[4] = 500+incrsp;
    break;

  case 6:
    //trapezio
    trapezio(300+incrsp, 370+incrsp, 370+incrsp, 300+incrsp); //coordinate veritici
    posxsp[5] = 300+incrsp;
    posysp[5] = 700+incrsp;
    break;

  default:
    break;
  }
}


//OSTACOLI
//scegli la figura in base al numero
void formaost(int nfigura, float l1, float l2) //input -> numero figura
{
  //colore figura
  fill(#A70202);
  // bordo della figura di colore nero
  stroke(0);

  switch(nfigura)
  {
  case 1:
    //quadrato
    figura(4, l1, l1,incrost);
    ostacolo_ArrayList.get(numero_ostacoli-1).vertici = 4;
    break;

  case 2:
    //rettangolo
    figura(4, l1, l2,incrost);
    ostacolo_ArrayList.get(numero_ostacoli-1).vertici = 4;
    break;

  case 3:
    //rombo
    figura(4, l2, l2,incrost); //sides, lato1, lato2
    ostacolo_ArrayList.get(numero_ostacoli-1).vertici = 4;
    break;

  case 4:
    //cerchio
    figura(30, l1, l1,incrost); //sides, lato1, lato2
    ostacolo_ArrayList.get(numero_ostacoli-1).vertici = 30;
    break;

  case 5:
    //triangolo
    figura(3, l1, l1,incrost); //sides, lato1, lato2
    ostacolo_ArrayList.get(numero_ostacoli-1).vertici = 3;
    break;

  case 6:
    //trapezio
    trapezio(l1+incrost, l2+incrost, l1+incrost, l2+incrost); //coordinate veritici
    ostacolo_ArrayList.get(numero_ostacoli-1).vertici = 4;
    break;

  default:
    break;
  }
}



//FUNZIONI

//disegna rombo, il cilindro e il triangolo
void figura(int sides, float lato1, float lato2, float incr)
{
  /*Calcola l'angolo in radianti per ogni lato della figura.
   Divide 360 gradi per il numero di lati per ottenere l'angolo.*/
  //sides -> numero segmenti
  float angle = -360 / sides; //disegna vertici in senso antiorario
  float x = 0,y=0;

  // Disegna la figura in alto
  beginShape();
  for (int i = 0; i < sides; i++) {
    x = cos(radians(i * angle)) * (lato1+incr);
    y = sin(radians(i * angle)) * (lato2+incr);
    vertex(x, y, 10);
  }
  endShape(CLOSE);
  
  // Disegna la figura in basso
  beginShape();
  for (int i = 0; i < sides; i++) {
    x = cos(radians(i * angle)) * (lato1+incr);
    y = sin(radians(i * angle)) * (lato2+incr);
    vertex(x, y, -10);
  }
  endShape(CLOSE);

  // Disegna il corpo
  beginShape(TRIANGLE_STRIP);
  /* Genera una serie di vertici lungo la circonferenza del rombo sia nella parte superiore
   che inferiore, collegandoli per formare una serie di triangoli.
   Questo crea l'effetto di una figura piena */
  for (int i = 0; i < sides+1; i++)
  {
    x = cos(radians(i * angle)) * (lato1+incr);
    y = sin(radians(i * angle)) * (lato2+incr);
    vertex(x, y, 10);
    vertex(x, y, -10);
  }
  endShape(CLOSE);
  
}

//primo vertice
//secondo vertice
void trapezio(float x1, float y1, float x2, float y2)  // input -> coordinate vertici
{
  int n = 10;
  for (int i = 0; i < n; i++)
  {
    //disegna i vertici in senso antiorario
    beginShape();
    //simmetrico rispetto all'asse y -> stessa x ma cambiata di segno
    vertex(x1, -y1, i); //in alto a dx
    vertex(-x1, -y1, i); //in alto a sx
    //simmetrico rispetto all'asse y -> stessa x ma cambiata di segno
    vertex(-x2, y2, i); //in basso a sx
    vertex(x2-50, y2-50, i); //in basso a dx
    endShape(CLOSE);
  }
  

}
