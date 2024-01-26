//variabile che indica quale figura hai scelto
int nfigura = 0;

//dimensioni oggetti
float lato;

void setup() 
{
 
  fullScreen(P3D); //al posto di size
  background(#A8DDEA);

}

void draw()
{
  // mi posiziono al centro 
  translate(width/2, height/2, -50); //per uscire premi esc
  
  // scegli luci
  
  //testo che mostra le istruzioni
  infoi();
  
  //cambiamo sistema di riferimento in modo da avere
  // x verso dx, y verso uscente, z verso alto
  rotateX(PI/4);
  rotateZ(PI/10);
  drawAxes(40);
    
    
  
  
  // spazio di lavoro
  forma(nfigura, false);
  
  
  //ostacoli
  
  
  

  
}

void keyPressed() 
{
  if (keyCode == '1') nfigura = 1;
  if (keyCode == '2') nfigura = 2;
  if (keyCode == '3') nfigura = 3;
  if (keyCode == '4') nfigura = 4;
  if (keyCode == '5') nfigura = 5;
  if (keyCode == '6') nfigura = 6;
  
  /*
  if (keyCode == RIGHT) 
  {
    if (giunto == 1) qr1 += incr;
    if (giunto == 2) qr2 += incr;
    if (giunto == 3) qr3 += incr;
    if (giunto == 4) qr4 += incr;
    if (giunto == 5) qr5 += incr;
    if (giunto == 6) qr6 += incr;
  }
  
  if (keyCode == LEFT) 
  {
    if (giunto == 1) qr1 -= incr;
    if (giunto == 2) qr2 -= incr;
    if (giunto == 3) qr3 -= incr;
    if (giunto == 4) qr4 -= incr;
    if (giunto == 5) qr5 -= incr;
    if (giunto == 6) qr6 -= incr;
  }
  
  if (keyCode == ENTER) 
  {
    qr1 = PI/2;
    qr2 = PI/2;
    qr3 = 2;
  }
  */
}

//funzione che disegna gli assi
//input -> lunghezza asse
void drawAxes(float lineLenght) {
  
  // disegno in rosso l'asse y  
  stroke(255, 0, 0);
  fill(255, 0, 0);
  pushMatrix();
  strokeWeight(3);
  line(0, 0, 0,  0, lineLenght, 0); //x1,y1,z1 , x2,y2,z2
  popMatrix();

// disegno in verde l'asse x  
  stroke(0, 255, 0);
  fill(0, 255, 0);
  pushMatrix();
  line(0, 0, 0, lineLenght, 0, 0); 
  popMatrix();
  
  // disegno in giallo l'asse z 
  //stroke(0, 0, 255);
  stroke(255, 255, 55);
  fill(255,255,55);
  //fill(0, 0, 255);
  pushMatrix();
  line(0, 0, 0, 0, 0, lineLenght); 
  popMatrix();
  noStroke();
}
