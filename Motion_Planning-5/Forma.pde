//SPAZIO OPERATIVO
//scegli la figura in base al numero
void formasp(int nfigura) //input -> numero figura
{
  //colore figura
  fill(#9B6F40);
  // bordo della figura di colore nero
  stroke(0);

  pushMatrix();
  //rotateZ(PI/4);

  switch(nfigura)
  {
  case 1:
    //quadrato
    //rotateZ(PI/4);
    //figura(4, 800, 800,incrsp);
    box(800+incrsp, 800+incrsp, 10); //quadrato
    posxsp[0] = 800+incrsp;
    posysp[0] = 800+incrsp;

    //rotateZ(PI/4);
    break;

  case 2:
    //rettangolo
    //figura(4, 700, 900,incrsp);
    box(700+incrsp, 900+incrsp, 10); // rettangolo
    posxsp[1] = 700+incrsp;
    posysp[1] = 900+incrsp;
    break;

  case 3:
    //rombo
    //figura(4, 570, 350, incrsp); //sides, lato1, lato2, incr
    disegnaRombo(0, 0, 1100, 1000);
    posxsp[2] = 1100+incrsp;
    posysp[2] = 1000+incrsp;
    break;

  case 4:
    //cerchio
    //figura(30, 800, 800, incrsp); //sides, lato1, lato2
    disegnaCerchio(0,0,800);
    posxsp[3] = 800+incrsp;
    posysp[3] = 800+incrsp;
    break;

  case 5:
    //triangolo
    //figura(3, 1000, 1000,incrsp); //sides, lato1, lato2
    disegnaTriangolo(0, 0, 1000+incrsp);
    posxsp[4] = 1000+incrsp;
    posysp[4] = 1000+incrsp;
    break;

  case 6:
    //trapezio
    //trapezio(300+incrsp, 600+incrsp, 600+incrsp, 300+incrsp); //coordinate veritici
    //trapezio(500,500,500,500);
    disegnaTrapezio(0,0,600,800,800);
    posxsp[5] = 600+incrsp;
    posysp[5] = 800+incrsp;
    break;

  default:
    break;
  }

  popMatrix();
}


//OSTACOLI
//scegli la figura in base al numero
void formaost(int nfigura, float l1, float l2) //input -> numero figura
{
  //colore figura
  //fill(#553B3B);
  // bordo della figura di colore nero
  stroke(0);

  pushMatrix();
  rotateZ(PI/4);
  lato1 = l1; //NON mettere qui l'aumento altrimenti gli ostacoli cambiano tutti insieme
  lato2 = l2;
    
  switch(nfigura)
  {
  case 1:
    //quadrato
    //figura(4, l1, l1,0);
    box(l1, l1, 10); //quadrato
    
    break;

  case 2:
    //rettangolo
    //figura(4, l1, l2,0);
    box(l1, l2, 10); // rettangolo

    break;

  case 3:
    //rombo
    //figura(4, l2, l2, 0); //sides, lato1, lato2
    disegnaRombo(0, 0, l1, l2);
    break;

  case 4:
    //cerchio
    //figura(30, l1, l1, 0); //sides, lato1, lato2
    disegnaCerchio(0,0,l1);
    break;

  case 5:
    //triangolo
    //figura(3, l1, l1,0); //sides, lato1, lato2
    disegnaTriangolo(0, 0, l1);
    break;

  case 6:
    //trapezio
    //trapezio(l1+0, l2+0, l1+0, l2+0); //coordinate veritici
    disegnaTrapezio(0,0,l1,l2,l2);
    break;

  default:
    break;
  }

  popMatrix();
}



//FUNZIONI

void disegnaRombo(float centroX, float centroY, float lunghezzaLatoX, float lunghezzaLatoY)
{

  float metaLunghezzaX = lunghezzaLatoX / 2;
  float metaLunghezzaY = lunghezzaLatoY / 2;

  for (int i=0; i<10; i++)
  {
    noStroke();
    if (i== 0 || i == 9)stroke(0);
    beginShape();
    vertex(centroX - metaLunghezzaX, centroY, i);
    vertex(centroX, centroY - metaLunghezzaY, i);
    vertex(centroX + metaLunghezzaX, centroY, i);
    vertex(centroX, centroY + metaLunghezzaY, i);
    endShape(CLOSE);
  }
}



void disegnaTriangolo (float x, float y, float sideLength) //x,y coordinate centro, sideLength lato triangolo
{ //i valori 3 servono per porre il triangolo al centro
  float height = sideLength * sqrt(3) / 2; // Calcolo dell'altezza del triangolo equilatero
  float x1 = x - sideLength / 2; // Calcolo della coordinata x del primo vertice
  float y1 = y + height / 3; // Calcolo della coordinata y del primo vertice
  float x2 = x + sideLength / 2; // Calcolo della coordinata x del secondo vertice
  float y2 = y + height / 3; // Calcolo della coordinata y del secondo vertice
  float x3 = x; // Coordinata x del terzo vertice, che si trova al centro della base del triangolo
  float y3 = y - 2*height / 3; // Calcolo della coordinata y del terzo vertice

  // Disegna il triangolo utilizzando le coordinate calcolate
  for (int i=0; i<10; i++)
  {
    noStroke();
    if (i== 0 || i == 9)stroke(0);
    triangle(x1, y1, x2, y2, x3, y3);
    translate(0, 0, 1);
  }
}

void disegnaTrapezio(float centroX, float centroY, float larghezzaSuperiore, float larghezzaInferiore, float altezza) 
{
  float metaLarghezzaSuperiore = larghezzaSuperiore / 2;
  float metaLarghezzaInferiore = larghezzaInferiore / 2;
  float metaAltezza = altezza / 2;
  
  for(int i=0; i<10; i++)
  {
    noStroke();
    if (i== 0 || i == 9)stroke(0);
  beginShape();
  vertex(centroX - metaLarghezzaSuperiore, centroY - metaAltezza,i);
  vertex(centroX + metaLarghezzaSuperiore, centroY - metaAltezza,i);
  vertex(centroX + metaLarghezzaInferiore, centroY + metaAltezza,i);
  vertex(centroX - metaLarghezzaInferiore, centroY + metaAltezza,i);
  endShape(CLOSE);
  }
}

void disegnaCerchio(float x,float y, float r)
{
  for (int i=0; i<10; i++)
  {
    noStroke();
    if (i== 0 || i == 9)stroke(0);
    circle(x,y,r);
    translate(0, 0, 1);
  }
  
}


//----------------------------------------------------------------------------------------------------------------------------------------


void figurachatgpt(int sides, float lato1, float lato2, float incr)
{
  float angle = 360.0 / sides;
  float x1=0, y1=0, x2=0, y2=0;
  // Calcola i vertici sulla circonferenza del cerchio esterno (lato1)
  beginShape();
  for (int i = 0; i < sides; i++) {
    float rad = radians(i * angle);
    x1 = cos(rad) * lato1+incr;
    y1 = sin(rad) * lato1+incr;
    vertex(x1, y1, 10);
  }
  endShape(CLOSE);
  // Calcola i vertici sulla circonferenza del cerchio interno (lato2)
  beginShape();
  for (int i = 0; i < sides; i++) {
    float rad = radians(i * angle);
    x2 = cos(rad) * lato2+incr;
    y2 = sin(rad) * lato2+incr;
    vertex(x2, y2, -10);
  }
  endShape(CLOSE);
  // Collega i vertici per formare i lati della figura
  beginShape();
  for (int i = 0; i < sides; i++) {
    vertex(x1, y1, 10);
    vertex(x2, y2, -10);
    float nextRad = radians((i + 1) * angle);
    x1 = cos(nextRad) * lato1+incr;
    y1 = sin(nextRad) * lato1+incr;
    x2 = cos(nextRad) * lato2+incr;
    y2 = sin(nextRad) * lato2+incr;
  }
  endShape(CLOSE);
}


//disegna rombo, il cilindro e il triangolo
void figuranostra(int sides, float lato1, float lato2, float incr)
{
  /*Calcola l'angolo in radianti per ogni lato della figura.
   Divide 360 gradi per il numero di lati per ottenere l'angolo.*/
  //sides -> numero segmenti
  float angle = -360 / sides; //disegna vertici in senso antiorario
  float x = 0, y=0;
  float xprev, yprev;

  // Disegna la figura in alto
  beginShape();
  for (int i = 0; i < sides; i++)
  {
    xprev = x;
    yprev = y;
    x = cos(radians(i * angle)) * (lato1+incr);
    //println(x);
    y = sin(radians(i * angle)) * (lato2+incr);
    // println(y);
    vertex(x, y, 10);
    lato_figura[i] = calcolo_lati(xprev, yprev, x, y);
    /*
   if(i==0)
     {
     stroke(0,255,0);
     line(xprev,yprev,x,y);
     lato_figura[i] = calcolo_lati(xprev,yprev,x,y);
     println("lato ",i,"dimensione ->",lato_figura[i]);
     }
     if(i==1)
     {
     stroke(0,0,255);
     line(xprev,yprev,x,y);
     lato_figura[i] = calcolo_lati(xprev,yprev,x,y);
     println("lato ",i,"dimensione ->",lato_figura[i]);
     }
     if(i==2)
     {
     stroke(255,0,0);
     line(xprev,yprev,x,y);
     lato_figura[i] = calcolo_lati(xprev,yprev,x,y);
     println("lato ",i,"dimensione ->",lato_figura[i]);
     }
     if(i==3)
     {
     stroke(#FAF323);
     line(xprev,yprev,x,y);
     lato_figura[i] = calcolo_lati(xprev,yprev,x,y);
     println("lato ",i,"dimensione ->",lato_figura[i]);
     }*/
    stroke(0);
    // posxsp[0] = lato_figura[1];
    //posysp[0] = lato_figura[2];
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

float calcolo_lati(float x0, float y0, float x1, float y1)
{
  float lato;
  lato = sqrt(pow(x0-x1, 2) + pow(y0-y1, 2));

  return lato;
}
