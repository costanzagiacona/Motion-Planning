//variabile che indica quale figura hai scelto
int nfigura = 0;

//dimensioni oggetti
float lato;
float incr = 0;
float kp = 5;

//per modificare la camera
float eyeY = 0;
float eyeX = 0;
// parametri visualizzazione
float angoloX = 0;
float angoloY = 0;
float angoloXpartenza = 0;
float angoloYpartenza = 0;

void setup()
{
  fullScreen(P3D); //al posto di size
  background(#A8DDEA);
}

void draw()
{
  camera((width/2.0)+eyeX, height/2-eyeY, (height/2.0)/tan(PI*60.0/360.0), width/2.0, height/2.0, 0, 0, 1, 0);

  background(#A8DDEA);
  // mi posiziono al centro
  translate(width/2, height/2, -50); //per uscire premi esc

  // scegli luci

  //testo che mostra le istruzioni
  infoi();

  //cambiamo sistema di riferimento in modo da avere
  // x verso dx, y verso uscente, z verso alto
  rotateX(PI/4);
  rotateZ(PI/10);

  //posso spostare la visuale con il cursore
  rotateY(-angoloY);
  rotateX(angoloX);

  //SPOSTIAMO IL SIST RIF PIù IN ALTO

  // spazio di lavoro
  forma(nfigura, false);

  // posizionamento sulla superficie del tavolo
  translate(0, 0, 10);
  drawAxes(40);


  //ostacoli
}



//funzione che disegna gli assi
//input -> lunghezza asse
void drawAxes(float lineLenght) {

  //disegno in rosso l'asse y
  stroke(255, 0, 0);
  fill(255, 0, 0);
  pushMatrix();
  strokeWeight(3);
  line(0, 0, 0, 0, lineLenght, 0); //x1,y1,z1 , x2,y2,z2
  popMatrix();

  //disegno in verde l'asse x
  stroke(0, 255, 0);
  fill(0, 255, 0);
  pushMatrix();
  line(0, 0, 0, lineLenght, 0, 0);
  popMatrix();

  //disegno in giallo l'asse z
  //stroke(0, 0, 255);
  stroke(255, 255, 55);
  fill(255, 255, 55);
  //fill(0, 0, 255);
  pushMatrix();
  line(0, 0, 0, 0, 0, lineLenght);
  popMatrix();
  noStroke();
}
