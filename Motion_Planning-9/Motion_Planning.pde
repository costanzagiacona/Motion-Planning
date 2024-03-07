//variabile che indica quale figura hai scelto
int nfigurasp = 1;
int nfiguraost = 1;

//orientamento ostacolo
float orientamento = 0; //radianti
ArrayList<Ostacolo> ostacolo_ArrayList= new ArrayList<Ostacolo>(); //vettore di ostacoli
int MAX_OST = 6; //numero massimo di ostacoli

//sovrapposizioni
boolean sovrapposizioneost = false;

//posizione  centro ostacolo non ancora instanziato
float x = 0;
float y = 0;
//posizione spazio di lavoro
float xsp = 0;
float ysp = 0;

//vettore dimensione lati figure
float[] posxsp;
float[] posysp;
float[] vertici_sp = new float[8];
float[] vertici_cerchio = new float[12]; //numero vertici cerchio (12 sopra (x e y))

//dimensioni oggetti
float lato1 = 50, lato2 = 70;
float incrsp = 0;
float incrost = 0;
float kp = 5; //incremento
float k = 20; //incremento lato per ostacolo ombra

//per modificare la camera
float eyeX = 0;
float eyeY = 0;
// parametri visualizzazione
float angoloX = 0;
float angoloY = 0;
float angoloXpartenza = 0;
float angoloYpartenza = 0;

//semaforo modifica spazio di lavoro
boolean semsp = true;
//semaforo modifica ostacoli
boolean semost = false;
//semaforo inserimento ostacoli
int semins = 0;

//robot
float pos_x_r = 180;          //  <====
float pos_y_r = -180;           //  <====
float r_r = 27;  //stima del diametro del robot rappresentato come un cerchio

//Variabili target
float xot = -110;        //        <=====
float yot = -170;        //        <=====
float r_target = 10;
float h_target = 5;
boolean ist_t = true;
//TARGET
int id_target = 9; //max 5 ostacoli

//parametri albero & movimento
float x_home = pos_x_r;
float y_home = pos_y_r;

//lunghezza laser
float laser_len = 1500;

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
float A, B, C, D;      // coefficienti polinomio a minima energia
boolean print = true;
boolean label_print = true;


float t = 0; // timer globale
float Dt = 30;  //NON è un differenziale: tf = ti + Dt
float ti;

//contatori
int i = 0;
int numero_ostacoli = 1; //numero corrente di ostacoli

void setup()
{
  //per uscire premi esc
  //fullScreen(P3D); //al posto di size
  size(1500, 900, P3D);
  background(#A8DDEA);

  // variabili per dimensioni spazio di lavoro
  posxsp = new float[6];
  posysp = new float[6];

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

  //DISEGNO ROBOT
  pushMatrix();
  translate(pos_x_r, pos_y_r); //SR robot
  formaost(4, 20, 20); //disegno robot
  popMatrix();

 //TARGET
  pushMatrix();
  //translate(xot, yot); //SR target
  //formaost(5, 20, 20); //disegno target
  Ostacolo_creazione(id_target, xot, yot, 20, 20, PI/4, 5);
  popMatrix();
 

  /*CREAZIONE OSTACOLI*/
  Ostacolo_creazione(1, -200, 10, lato1, lato2, PI/4, 1);
 /* pushMatrix();
  fill(#C6C4C0); //grigio
  translate(-200, 10, -5);
  rotateZ(PI/4);
  formaost(nfiguraost, lato1+incrost+k, lato2+incrost+k); //ombra
  popMatrix();
*/
  

  if (semost == true && semins != 0)
  {
    pushMatrix();
    fill(#FCA63B); //arancione
    translate(x, y, 5);
    rotateZ(orientamento);
    formaost(nfiguraost, lato1+incrost, lato2+incrost);
    fill(#C6C4C0); //grigio
    translate(0, 0, -10);
    formaost(nfiguraost, lato1+incrost+k, lato2+incrost+k); //ombra
    popMatrix();
  }


  for (Ostacolo o : ostacolo_ArrayList)
  {
    //non mostriamo il primo ostacolo poichè lo mostriamo alla riga 153
    //if (o.id != 0) Ostacolo_creazione(o.id, o.posx, o.posy, o.lato1, o.lato2, o.alpha, o.forma);
    Ostacolo_creazione(o.id, o.posx, o.posy, o.lato1, o.lato2, o.alpha, o.forma);
  }
  //println(ostacolo_ArrayList);

  //SCAN
  if (!semost && !semsp ) //se abbiamo scelto il tavolo e gli ostacoli
  {
    if (token) //parte di movimento
    {
      //FASE DI SCANNER
      s = scan(pos_x_r, pos_y_r, laser_len, #6920E0);
     
     if (vertex_found)
      {
        //aggiungo nodo solo quando trovo un nuovo vertice
        make_tree(nodo_corrente); //funzione che aggiunge il vertice eventualmente trovato ai links del current node
        vertex_found = false;
      }
       print_tree();
       
      if (s)
      { //se trovo vertice mi sposto lì
        // cambia token quando lo scanner trova il target, e lo passa all'else responsabile della fase di movimento
        token = false;

        j = 0;
        exploring_node++;
        nodo_successivo = nodo.get(exploring_node);

        // trova il percorso tra il nodo corrente e il prossimo da visitare
        percorso = find_path(nodo_corrente, nodo_successivo);

        // coordinate del nodo di partenza
        x1 = percorso.get(j).x;
        y1 = percorso.get(j).y;

        // coordinate del target (punto da raggiungere)
        x2 = xot;
        y2 = yot;

        t = 0;
        ti = t;

        /* Il valore dei coefficienti è stato trovato attraverso la spline cubica naturale
         che rappresenta una scelta possibile nel caso di un polinomio di terzo ordine.
         Supponiamo che il robot si sposti tra i punti con velocità costante e pari a 1 (v=1).
         Usiamo ti, perché il polinomio cambia in funzione del segmento percorso.
         Un'altra possibilità sarebbe l'uso delle derivate.
         */
        A = (2*pow(ti, 3)+3*Dt*pow(ti, 2))/(pow(Dt, 3));
        B = -(6*pow(ti, 2)+6*Dt*ti)/(pow(Dt, 3));
        C = (6*ti+3*Dt)/(pow(Dt, 3));
        D = -2/(pow(Dt, 3));
      }

      if (alpha >= 0 && alpha < start_alpha)
      {
        //ciclo di scan completo => cambia token per muoversi

        token = false;
        arrived = false;

        //inizializza il path una volta che lo scan è finito per preparare il percorso
        j = 0;
        exploring_node++;
        nodo_successivo = nodo.get(exploring_node);

        percorso = find_path(nodo_corrente, nodo_successivo);

        // coordinate nodo di partenza
        x1 = percorso.get(j).x;
        y1 = percorso.get(j).y;
        //coordinate nodo di destinazione
        x2 = percorso.get(j+1).x;
        y2 = percorso.get(j+1).y;

        t = 0;
        ti = t;

        A = (2*pow(ti, 3)+3*Dt*pow(ti, 2))/(pow(Dt, 3));
        B = -(6*pow(ti, 2)+6*Dt*ti)/(pow(Dt, 3));
        C = (6*ti+3*Dt)/(pow(Dt, 3));
        D = -2/(pow(Dt, 3));
      }
    } 
    else
    {
      //fase di movimento

      if (!s)
      {
        //scan terminato, target non trovato
        if (!arrived)
        {
          print_tree();

          // si muove tra due nodi del grafo
          float[] new_pos = move(x1, y1, x2, y2);

          // le coordinate di destinazione diventano quelle del robot, che così si sposta lì
          pos_x_r = new_pos[0];
          pos_y_r = new_pos[1];

          float toll2 = 1;

          if (abs(pos_x_r - x2) < toll2 && abs(pos_y_r - y2) < toll2 )
          {
            j++;
            if (j < (percorso.size() -1))
            {
              /* se sono arrivato in un nodo non punto finale del path, inizializzo nuovamente le variabili di definizione traiettoria */
              x1 = percorso.get(j).x;
              y1 = percorso.get(j).y;
              x2 = percorso.get(j+1).x;
              y2 = percorso.get(j+1).y;

              t = 0;
              ti = t;

              A = (2*pow(ti, 3)+3*Dt*pow(ti, 2))/(pow(Dt, 3));
              B = -(6*pow(ti, 2)+6*Dt*ti)/(pow(Dt, 3));
              C = (6*ti+3*Dt)/(pow(Dt, 3));
              D = -2/(pow(Dt, 3));
            } else if (j == (percorso.size() - 1))
            {
              print_tree();

              //se sono arrivato all'ultimo nodo dell'array path 

              //arrived = true (ma è superfluo)

              nodo_corrente = nodo_successivo;

              token = true;
            }
          }
        }
      } else
      {  // if (s) -> target trovato
        float toll2 = 1;

        if (abs(pos_x_r - x2) < toll2 && abs(pos_y_r - y2) < toll2 )
        {
          print_tree();
        } else
        {
          print_tree();
          // x2, y2 sono le coordinate del target
          float[] new_pos = move(x1, y1, x2, y2);
          // spostamento robot nel punto del target
          pos_x_r = new_pos[0];
          pos_y_r = new_pos[1];
        }
      }
    }
  }

  noStroke();
  t++;
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
