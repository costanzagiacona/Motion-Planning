//variabile che indica quale figura hai scelto
int nfigurasp = 1;
int nfiguraost = 1;

//orientamento ostacolo
float orientamento = 0; //radianti
ArrayList<Ostacolo> ostacolo_ArrayList= new ArrayList<Ostacolo>(); //vettore di ostacoli
int MAX_OST = 5; //numero massimo di ostacoli

//sovrapposizioni
boolean sovrapposizioneost = false;

//posizione ostacolo
float x = 0;
float y = 0;
//posizione spazio di lavoro
float xsp = 0;
float ysp = 0;

//vettore dimensione lati figure
float[] posxsp; //inzializzazione
float[] posysp;

//dimensioni oggetti
float lato;
float incrsp = 0;
float incrost = 0;
float kp = 5;
float k = 5;

//per modificare la camera
float eyeY = 0;
float eyeX = 0;
// parametri visualizzazione
float angoloX = 0;
float angoloY = 0;
float angoloXpartenza = 0;
float angoloYpartenza = 0;

//semaforo modifica spazio di lavoro
boolean semsp= true;
//semaforo modifica ostacoli
boolean semost = false;
//semaforo inserimento ostacoli
int semins = 0;
/*
1 - dimensione e orientamento
 2 - posizione
 */


//contatori
int i = 0;
int numero_ostacoli = 0; //numero corrente di ostacoli

void setup()
{
  //per uscire premi esc
  //fullScreen(P3D); //al posto di size
  size(1500, 900, P3D);
  background(#A8DDEA);

  posxsp = new float[6];
  posysp = new float[6];

  for (int i=0; i<6; i++)
  {
    posxsp[i] = 0;
    posysp[i] = 0;
  }
}

void draw()
{
  camera((width/2.0)+eyeX, height/2-eyeY, (height/2.0)/tan(PI*60.0/360.0), width/2.0, height/2.0, 0, 0, 1, 0);

  background(#A8DDEA);
  // mi posiziono al centro
  translate(width/2, height/2, -50);

  // scegli luci
 // directionalLight(126, 126, 126, 0, 0, -1);
  //ambientLight(122, 122, 122);
  //directionalLight(126,126,126,0,0,0.7);
  //ambientLight(200,200,200);
  //directionalLight(0, 0, 0, 0, 0, -1);
   
  //testo che mostra le istruzioni
  infoi();

  //cambiamo sistema di riferimento in modo da avere
  // x verso dx, y verso uscente, z verso alto
  rotateX(PI/4);
  rotateZ(PI/10);

  //posso spostare la visuale con il cursore
  rotateY(-angoloY);
  rotateX(angoloX);

  //spostiamo il riferimento più in alto per far vedere meglio le figure
  translate(0, -100, 0);


  /*SPAZIO DI LAVORO*/
  formasp(nfigurasp);

  // posizionamento sulla superficie del tavolo
  translate(0, 0, 10);
  drawAxes(40);


  /*CREAZIONE OSTACOLI*/


 Ostacolo_creazione(0, -200, 10, 50, 70, PI/4, 1);
 
 
  if (semost == true && semins != 0)
  {
   pushMatrix();
   fill(#6920E0);
   translate(x,y,10);
   rotateZ(orientamento);
   formaost(nfiguraost,50+incrost,70+incrost);
   fill(GRAY);
   translate(0,0,-5);
   //formaost(nfiguraost,50+incrost+k,70+incrost+k); //ombra
   popMatrix();
  }


  for (Ostacolo o : ostacolo_ArrayList)
  {
    //non mostriamo il primo ostacolo poichè lo mostriamo alla riga 112
    if (o.id != 0) Ostacolo_creazione(o.id, o.posx, o.posy, o.lato1, o.lato2, o.alpha, o.forma);
    //println("oggetto ->" ,o.id,o.posx, o.posy);
  }
  
 
  
 
  //println(semins);
  //println(numero_ostacoli);
  //println(ostacolo_ArrayList);
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
  stroke(255, 255, 55);
  fill(255, 255, 55);
  pushMatrix();
  line(0, 0, 0, 0, 0, lineLenght);
  popMatrix();
  noStroke();
}
