//variabile che indica quale figura hai scelto
int nfigurasp = 1;
int nfiguraost = 1;

//orientamento ostacolo
float orientamento = 0; //radianti
ArrayList<Ostacolo> ostacolo_ArrayList= new ArrayList<Ostacolo>(); //vettore di ostacoli
int MAX_OST = 5; //numero massimo di ostacoli

//sovrapposizioni
boolean sovrapposizioneost = false;

//posizione  centro ostacolo non ancora instanziato
float x = 0;
float y = 0;
//posizione spazio di lavoro
float xsp = 0;
float ysp = 0;

//vettore dimensione lati figure
float[] posxsp; //inzializzazione
float[] posysp;
//dimensione lati
float[] lato_figura = new float[4];
float[] vertici_sp = new float[8];

//dimensioni oggetti
float lato1 = 50, lato2 = 70;
float incrsp = 0;
float incrost = 0;
float kp = 5; //incremento
float k = 10; //incremento lato per ostacolo ombra

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

//roomba
PShape roomba;
float pos_x_r = -180;          //  <====
float pos_y_r = 100;           //  <====
float r_r = 27;  //stima del diametro del roomba, con tolleranza, per evitare le collisioni


//parametri tree & movimento
float x_home = pos_x_r;
float y_home = pos_y_r;

//grafo
Nodo nodo_corrente, nodo_successivo;
Albero albero;
Nodo target;
ArrayList<Nodo> nodo;
float r_nodo = 10;
int exploring_node = 0;
boolean token = true;
ArrayList<Nodo> nodi_visitati;
int j = 0;
boolean arrived = false;
ArrayList<Nodo> percorso;
float x1, x2, y1, y2;
float A, B, C, D;
boolean print = true;
boolean label_print = true;


float t = 0; // timer globale
float Dt = 30;  //NON è un differenziale: tf = ti + Dt
float ti;


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

  //grafo
  Nodo first_root = new Nodo("source", x_home, y_home);
  nodo = new ArrayList<Nodo>();
  albero = new Albero(first_root);
  nodo_corrente = first_root;
}

void draw()
{
  camera((width/2.0)+eyeX, height/2-eyeY, (height/2.0)/tan(PI*60.0/360.0), width/2.0, height/2.0, 0, 0, 1, 0);

  background(#A8DDEA);
  // mi posiziono al centro
  translate(width/2, height/2, -50);

  //testo che mostra le istruzioni
  infoi();

  //cambiamo sistema di riferimento in modo da avere
  // x verso dx, y verso uscente, z verso alto
  rotateX(PI/4);
  rotateZ(PI/10);

  //posso spostare la visuale con il cursore
  rotateY(-angoloY);
  rotateX(angoloX);

  //spostiamo il sist riferimento più in alto per far vedere meglio le figure
  translate(0, -100, 0);


  /*SPAZIO DI LAVORO*/
  formasp(nfigurasp);

  // posizionamento sulla superficie del tavolo
  translate(0, 0, 10);
  drawAxes(40);
  /*
   stroke(0,0,255);
   strokeWeight(10);
   line(0,-450,0,450);
   strokeWeight(2);
   */

  /*CREAZIONE OSTACOLI*/

  //noFill();
  Ostacolo_creazione(0, -200, 10, lato1, lato2, PI/4, 1);


  if (semost == true && semins != 0)
  {
    pushMatrix();
    fill(#6920E0);
    translate(x, y, 10);
    rotateZ(orientamento);
    formaost(nfiguraost, lato1+incrost, lato2+incrost);
    fill(GRAY);
    //translate(0, 0, -5);
    //formaost(nfiguraost,50+incrost+k,70+incrost+k); //ombra
    popMatrix();
  }


  for (Ostacolo o : ostacolo_ArrayList)
  {
    //non mostriamo il primo ostacolo poichè lo mostriamo alla riga 163
    if (o.id != 0) Ostacolo_creazione(o.id, o.posx, o.posy, o.lato1, o.lato2, o.alpha, o.forma);
    //println("Ostacolo for MP lato1 e lato2:",lato1,lato2);
    //println("oggetto ->" ,o.id,o.posx, o.posy);
  }


  //SCAN
  if (!semost && !semsp ) //se abbiamo scelto il tavolo e gli ostacoli
  {
    //DISEGNO ROBOT
    pushMatrix();
    translate(180, -180); //SR robot
    //figura(60, 5, 5, 0);
    formaost(4, 20, 20);
    popMatrix();

    //FASE DI SCANNER
    //s = scan(180, -180, 600*sqrt(2), #6920E0);
    s = scan(180, -180, 900, #6920E0);
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
  line(0, 0, 0, 0, lineLenght, 0); //x1,y1,z1, x2,y2,z2
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
