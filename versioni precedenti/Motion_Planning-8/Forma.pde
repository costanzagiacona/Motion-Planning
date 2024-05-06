//--------------------- SPAZIO OPERATIVO ---------------------
//scegli la figura in base al numero
void formasp(int nfigura) //input -> numero figura
{
  //colore figura
  fill(#9B6F40);
  // bordo della figura di colore nero
  stroke(0);
  float l1=0, l2=0;

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
    l1 = 800+incrsp;
    l2 = l1;
    vertici_sp(nfigura, l1, l2);
    //rotateZ(PI/4);
    break;

  case 2:
    //rettangolo
    //figura(4, 700, 900,incrsp);
    box(700+incrsp, 900+incrsp, 10); // rettangolo
    posxsp[1] = 700+incrsp;
    posysp[1] = 900+incrsp;
    l1 = 700+incrsp;
    l2 = 900+incrsp;
    vertici_sp(nfigura, l1, l2);
    break;

  case 3:
    //rombo
    //figura(4, 570, 350, incrsp); //sides, lato1, lato2, incr
    disegnaRombo(0, 0, 1100+incrsp, 1000+incrsp);
    posxsp[2] = 1100+incrsp;
    posysp[2] = 1000+incrsp;
    l1 = 1100+incrsp;
    l2 = 1000+incrsp;
    vertici_sp(nfigura, l1, l2);
    //rotateZ(PI/4);
    break;

  case 4:
    //cerchio
    //figura(30, 800, 800, incrsp); //sides, lato1, lato2
    disegnaCerchio(0, 0, 800+incrsp);
    posxsp[3] = 800+incrsp;
    posysp[3] = 800+incrsp;
    l1 = 800+incrsp;
    l2 = 800+incrsp;
    vertici_sp(nfigura, l1, l2);
    break;

  case 5:
    //triangolo
    //figura(3, 1000, 1000,incrsp); //sides, lato1, lato2
    disegnaTriangolo(0, 0, 1000+incrsp);
    posxsp[4] = 1000+incrsp;
    posysp[4] = 1000+incrsp;
    l1 = 1000+incrsp;
    l2 = 1000+incrsp;
    vertici_sp(nfigura, l1, l2);
    break;

  case 6:
    //trapezio
    //trapezio(300+incrsp, 600+incrsp, 600+incrsp, 300+incrsp); //coordinate veritici
    //trapezio(500,500,500,500);
    disegnaTrapezio(0, 0, 600+incrsp, 800+incrsp, 800+incrsp);
    posxsp[5] = 600+incrsp;
    posysp[5] = 800+incrsp;
    l1 = 600+incrsp;
    l2 = 800+incrsp;
    vertici_sp(nfigura, l1, l2);
    break;

  default:
    break;
  }

  popMatrix();
}


void vertici_sp(int nfigura, float l1, float l2)
{
  float h=0;
  float d=0;
  switch(nfigura)
  {
  case 1: //QUADRATO
  case 2: //RETTANGOLO
    //coordinate ostacolo rispetto SR0
    //vertice 1
    vertici_sp[0] = (-l1/2); //in basso a sx
    vertici_sp[1] = (-l2/2);
    //vertice 2
    vertici_sp[2] = (l1/2); //in basso a dx
    vertici_sp[3] = (l2/2);
    //vertice 3
    vertici_sp[4] = (-l1/2); //in alto a sx
    vertici_sp[5] = (-l2/2);
    //vertice 4
    vertici_sp[6] = -(-l1/2); //in alto a dx
    vertici_sp[7] = (l2/2);
    break;

  case 3: //ROMBO
    //diagonale rombo
    d = sqrt(pow(l1, 2)+pow(l2, 2));
    vertici_sp[0] = 0; //in basso
    vertici_sp[1] = d/3;
    //vertice 2
    vertici_sp[2] = d/2.7; //dx
    vertici_sp[3] = 0;
    //vertice 3
    vertici_sp[4] = -d/2.7; //sx
    vertici_sp[5] = 0;
    //vertice 4
    vertici_sp[6] = 0; //avanti, quello lontano
    vertici_sp[7] = -d/3;
    break;

  case 4: //CERCHIO
    /*Calcola l'angolo in radianti per ogni lato della figura.
     Divide 360 gradi per il numero di vertici per ottenere l'angolo.*/
    //30 -> numero vertici
    float angle = -360 / 120; //disegna vertici in senso antiorario
    float x = 0, y = 0;
    //sphere(20);
    for (int i = 0; i < 120; i=i+2) //aumentando il numero dei vertici viene più preciso lo scan
    {
      x = cos(radians(i * angle)) * (l1/2);
      y = sin(radians(i * angle)) * (l1/2);
      vertici_cerchio[i] = x;
      vertici_cerchio[i+1] = y;
      //println(vertici_cerchio[i], vertici_cerchio[i+1]);
      //pushMatrix();
      //translate(x,y);
      //stroke(255,0,0);
      //sphere(20);
      //popMatrix();
      
    }
    //for(int i = 0; i < 120; i++) println("VERTICI", vertici_cerchio[i]);

    break;

  case 5: //TRIANGOLO
    h = (l1*sqrt(3))/2;
    //coordinate ostacolo rispetto SR0
    //vertice 1
    vertici_sp[0] = 0; //in basso
    vertici_sp[1] = (-h/1.5);
    //vertice 2
    vertici_sp[2] = (l1/2); //dx
    vertici_sp[3] = (h/3);
    //vertice 3
    vertici_sp[4] = -l1/2; //sx
    vertici_sp[5] = (h/3);
    break;

  case 6: //TRAPEZIO
    h = l2; //altezza
    vertici_sp[0] = -l2/2; //in basso a sx
    vertici_sp[1] = h/2;
    //vertice 2
    vertici_sp[2] = l2/2; //dx
    vertici_sp[3] = h/2;
    //vertice 3
    vertici_sp[4] = -l1/2; //sx
    vertici_sp[5] = -h/2;
    //vertice 4
    vertici_sp[6] = l1/2; //avanti, quello lontano
    vertici_sp[7] = -h/2;
    break;
  }
}


// --------------------- OSTACOLI ---------------------
//scegli la figura in base al numero
void formaost(int nfigura, float l1, float l2) //input -> numero figura
{
  // bordo della figura di colore nero
  stroke(0);

  pushMatrix();
  rotateZ(PI/4);
  //NON mettere qui l'aumento altrimenti gli ostacoli cambiano tutti insieme

  switch(nfigura)
  {
  case 1:
    //quadrato
    box(l1, l1, 10); //quadrato

    break;

  case 2:
    //rettangolo
    box(l1, l2, 10); // rettangolo
    break;

  case 3:
    //rombo
    disegnaRombo(0, 0, l1, l2);
    break;

  case 4:
    //cerchio
    //figura(30, l1, l1, 0); //sides, lato1, lato2
    disegnaCerchio(0, 0, l1);
    break;

  case 5:
    //triangolo
    disegnaTriangolo(0, 0, l1);
    break;

  case 6:
    //trapezio
    disegnaTrapezio(0, 0, l1, l2, l2);
    break;

  default:
    break;
  }

  popMatrix();
}


//FUNZIONI disegno

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
  // spigoli lungo z
  stroke(0);
  line(centroX - metaLunghezzaX, centroY, 0, centroX - metaLunghezzaX, centroY, 10);
  line(centroX, centroY - metaLunghezzaY, 0, centroX, centroY - metaLunghezzaY, 10);
  line(centroX + metaLunghezzaX, centroY, 0, centroX + metaLunghezzaX, centroY, 10);
  line(centroX, centroY + metaLunghezzaY, 0, centroX, centroY + metaLunghezzaY, 10);
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
  // spigoli lungo z
  stroke(0);
  line(x1, y1, 0, x1, y1, -10);
  line(x2, y2, 0, x2, y2, -10);
  line(x3, y3, 0, x3, y3, -10);
}

void disegnaTrapezio(float centroX, float centroY, float larghezzaSuperiore, float larghezzaInferiore, float altezza)
{
  float metaLarghezzaSuperiore = larghezzaSuperiore / 2;
  float metaLarghezzaInferiore = larghezzaInferiore / 2;
  float metaAltezza = altezza / 2;

  for (int i=0; i<10; i++)
  {
    noStroke();
    if (i== 0 || i == 9)stroke(0);
    beginShape();
    vertex(centroX - metaLarghezzaSuperiore, centroY - metaAltezza, i);
    vertex(centroX + metaLarghezzaSuperiore, centroY - metaAltezza, i);
    vertex(centroX + metaLarghezzaInferiore, centroY + metaAltezza, i);
    vertex(centroX - metaLarghezzaInferiore, centroY + metaAltezza, i);
    endShape(CLOSE);
  }
  // spigoli lungo z
  stroke(0);
  line(centroX - metaLarghezzaSuperiore, centroY - metaAltezza, 0, centroX - metaLarghezzaSuperiore, centroY - metaAltezza, 10);
  line(centroX + metaLarghezzaSuperiore, centroY - metaAltezza, 0, centroX + metaLarghezzaSuperiore, centroY - metaAltezza, 10);
  line(centroX + metaLarghezzaInferiore, centroY + metaAltezza, 0, centroX + metaLarghezzaInferiore, centroY + metaAltezza, 10);
  line(centroX - metaLarghezzaInferiore, centroY + metaAltezza, 0, centroX - metaLarghezzaInferiore, centroY + metaAltezza, 10);
}

void disegnaCerchio(float x, float y, float r)
{
  for (int i=0; i<10; i++)
  {
    noStroke();
    if (i== 0 || i == 9)stroke(0);
    circle(x, y, r);
    translate(0, 0, 1);
  }
}
