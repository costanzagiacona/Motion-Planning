//VARIABILI
// ---------- OSTACOLO ----------
//posizione  centro ostacolo non ancora instanziato
float x = 0;
float y = 0;
//orientamento ostacolo non ancora instanziato
float orientamento = 0; //radianti
//variabile che indica quale figura hai scelto
int nfiguraost = 1; //figura ostacolo
//vettore di ostacoli istanziati
ArrayList<Ostacolo> ostacolo_ArrayList= new ArrayList<Ostacolo>();
//numero massimo di ostacoli
int MAX_OST = 6;
//sovrapposizioni ostacolo con ostacolo e\o ostacolo con tavolo
boolean sovrapposizioneost = false;
//incremento dimensione lati
float incrost = 0;
//ostacolo ombra
float k = 20; //incremento lato per ostacolo ombra


//---------- SPAZIO DI LAVORO ----------
//posizione centro spazio di lavoro
float xsp = 0;
float ysp = 0;
//variabile che indica quale figura hai scelto
int nfigurasp = 1; //figura spazio di lavoro
//dimensioni iniziali
float lato1 = 50, lato2 = 70;
//vettore dimensione lati figure dopo che è stato incrementato
//dimensione 6 perchè sono 6 figure e vogliamo salvare ogni possibie
// modifica per migliorare la vista all'utente
float[] posxsp = new float[6]; //lunghezza lato sp lungo x
float[] posysp = new float[6]; //lunghezza lato sp lungo y
//incremento lati figura
float incrsp = 0;
///vertici
float[] vertici_sp = new float[8]; //numero di vertici figura sp
//float[] vertici_cerchio = new float[12]; //numero vertici cerchio (12 sopra (x e y))
float[] vertici_cerchio = new float[24];


//---------- PARAMETRO COMUNE OSTACOLO E SP ----------
//dimensioni oggetti comune
float kp = 5; //incremento lati figure tramite interazioni -> incremento += kp;


//---------- VISUALE ----------
//per modificare la camera
float eyeX = 0;
float eyeY = 0;
// parametri visualizzazione // ------------------------------------------------------------------> cercare nel codice e commentare bene
float angoloX = 0;
float angoloY = 0;
float angoloXpartenza = 0;
float angoloYpartenza = 0;


// ---------- SEMAFORI ----------
// SP
//semaforo modifica spazio di lavoro
//se true puoi modificare dimensione e figura, dopo aver premuto ENTER diventa false
boolean semsp = true;
//OSTACOLO
//semaforo inserimento ostacoli
boolean semost = false;
//semaforo modifica ostacoli
//regola i passaggi per inserire correttamente l'ostacolo
// 0 -> creazione oggetto di default al centro
// 1 -> possibilità di modificare la dimensione e l'orientamento
// 2 -> posizionamento sul tavolo e modifica dimensione ombra
int semins = 0;


//---------- ROBOT ----------
//posizione
float pos_x_r = 180;             //    <====
float pos_y_r = -180;           //    <====
//raggio robot
float r_r = 27;  //stima del diametro del robot rappresentato come un cerchio


//---------- TARGET ----------
//posizione
float xot = -180;              //    <=====
float yot = 250;              //     <=====
//dimensione lato target
float r_target = 20;
float h_target = 5; // ------------------------------------------------------------------> cercare nel codice altrimenti cancellare
//se un ostacolo è il target questo flag è true
boolean is_t = true; //nella classe ostacolo
//identificatore
int id_target = 0; //max 6 ostacoli


//---------- ALBERO ----------
//parametri albero & movimento
//l'albero parte dalla posizione iniziale del robot
float x_home = pos_x_r;
float y_home = pos_y_r;
//instanzio l'albero
Albero albero;


//---------- GRAFO ----------
Nodo nodo_corrente, nodo_successivo;
Nodo target;
Nodo root;
ArrayList<Nodo> nodo; //lista nodi istanziati
ArrayList<Nodo> nodi_visitati; //lista nodi visitati
ArrayList<Nodo> percorso; //lista dei nodi sul percorso

float r_nodo = 10; //dimensione nodo da disegnare
int exploring_node = 0; //nodi visitati
boolean token = true; //se true eseguo scansione con scan
boolean arrived = false; //se trovo il target sono arrivato

float x1, x2, y1, y2; //coordinate ipotetico nodo1 e ipotetico nodo2
float A, B, C, D;      // coefficienti polinomio a minima energia
boolean print = true; //disegno il grafo sul tavolo
boolean label_print = true; //mostro i numeri dei nodi

//lista di nodi visitati, ordinata,  per creare curva di BEZIER
//ArrayList<Nodo> nodi_visitati_bezier;
ArrayList<Nodo> nodi_visitati_bezier = new ArrayList<Nodo>();


//---------- SCANNER ----------
boolean s = false;   //true se ho trovato il target, modificata in scan
int num_iter = 800; //per far girare lo scanner
float start_alpha = (2*PI)/420; //angolo iniziale con cui si sposta lo scanner
float alpha = start_alpha;//angolo con cui si sposta lo scanner
float[] x_prev = {0, 0};   //coordinate dei punti i-1,i-2 RISPETTO A SR0
float[] y_prev = {0, 0};
float x_vert, y_vert; //coordinate vertice trovato, modificato in scan
boolean vertex_found = false;//true se ho trovato un vertice, modificato in scan


// ---------- LASER ----------
//lunghezza laser
float laser_len = 1500;


// ---------- FORMULE ----------
float t = 0; // timer globale
float Dt = 30;  //NON è un differenziale: tf = ti + Dt
float ti;

//---------- CONTATORI ----------
int i = 0;
int j = 0; //posizione nel mio percorso tra nodo partenza e nodo destinazione
int numero_ostacoli = 3; //numero corrente di ostacoli (conta da 0)
int id_ost = 2;
int bezier = 0;
int exploring = 0;
int num_nodi = 0;



//---------- PROGRAMMA ----------
void setup()
{
  //per uscire premi esc
  //fullScreen(P3D); //al posto di size
  size(1500, 900, P3D);
  background(#A8DDEA);

  // variabili per dimensioni spazio di lavoro
  //posxsp = new float[6];
  //posysp = new float[6];

  //grafo
  Nodo first_root = new Nodo("source", x_home, y_home, 0); //creo il nodo radice nella posizione iniziale del robot
  target = new Nodo("target", xot, yot, 560); //creo nodo target
  nodo = new ArrayList<Nodo>(); //creo lista nodi
  albero = new Albero(first_root); //instanzio albero
  nodo_corrente = first_root; //mi posiziono sulla radice

  root = first_root;
  root.visitato= true;
  //il percorso di Bezier deve partire dalla radice
  nodi_visitati_bezier.add(first_root);
}

void draw()
{
  camera((width/2.0)+eyeX, height/2-eyeY, (height/2.0)/tan(PI*60.0/360.0), width/2.0, height/2.0, 0, 0, 1, 0);

  background(#A8DDEA);
  // mi posiziono al centro della finestra
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

  //posizionamento sulla superficie del tavolo
  translate(0, 0, 10);
  drawAxes(40);

  /*DISEGNO ROBOT*/
  pushMatrix();
  translate(pos_x_r, pos_y_r); //SR robot
  //disegno robot
  formaost(4, 20, 20); //funzione in 'Forma'
  popMatrix();

  //*TARGET*/
  //creo il target come un ostacolo ma pongo l'ultima variabile a true per
  //far sapere al programma che è il punto di arrivo
  pushMatrix();
  Ostacolo_creazione(id_target, xot, yot, r_target, r_target, PI/4, 5, true, 20); //funzione in 'Ostacoli'
  popMatrix();


  /*CREAZIONE OSTACOLI DI DEFAULT*/
  //Ostacolo_creazione(0, -200, 10, lato1, lato2, PI/4, 1); //quadrato
  Ostacolo_creazione(1, 200, 10, lato1, lato2, PI/4, 1, false, 20); //quadrato ------
  //Ostacolo_creazione(2, 200, 100, lato1+50, lato2, PI/4, 4); //cerchio
  //Ostacolo_creazione(2, -150, 250, lato1+30, lato2+30, -PI/3, 6); //trapezio
  Ostacolo_creazione(2, 170, 230, lato1+30, lato2+30, -PI/3, 6, false, 20); //trapezio ----


  /*CREAZIONE OSTACOLI DA PARTE DELL'UTENTE*/
  if (semost == true && semins != 0)
  {
    pushMatrix();
    fill(#FCA63B); //arancione
    translate(x, y, 5); //SR ostacolo (all'inizio è sempre al centro)
    rotateZ(orientamento); //modifica orientamento (vedere in "Interazioni")
    if (nfiguraost == 4) //cerchio
    {
      formaost(nfiguraost, ((lato1)/4)+(incrost/4), lato2+incrost); //funzione in 'Forma'
      fill(#C6C4C0); //grigio
      translate(0, 0, -10);
      formaost(nfiguraost, ((lato1)/4)+(incrost/4)+k, lato2+incrost+k); //ombra
      popMatrix();
    } 
    else
    {
      formaost(nfiguraost, lato1+incrost, lato2+incrost);
      fill(#C6C4C0); //grigio
      translate(0, 0, -10);
      formaost(nfiguraost, lato1+incrost+k, lato2+incrost+k); //ombra
      popMatrix();
    }
  }


  //mostriamo a schermo tutti gli ostacoli instanziati
  //altrimenti non vedremo quelli inseriti dall'utente poichè la funzione
  //'Ostacolo creazione' sta in 'Interazioni' e non nel 'draw'
  for (Ostacolo o : ostacolo_ArrayList)
  {
    Ostacolo_creazione(o.id, o.posx, o.posy, o.lato1, o.lato2, o.alpha, o.forma, o.is_t, o.ombra_k); //funzione in 'Ostacoli'
    //println("Id ostacolo dentro array ", o.id);
  }
  //println(ostacolo_ArrayList);


  /*SCAN*/
  if (!semost && !semsp ) //se abbiamo scelto il tavolo e gli ostacoli procediamo con la scansione
  {
    if (token) //parte di movimento
    {
      //FASE DI SCANNER
      //input - pos x robot, pos y robot, lunghezza laser, colore laser
      s = scan(pos_x_r, pos_y_r, laser_len, #6920E0); //eseguo lo scan, false se non trova target

      //NUOVO VERTICE
      if (vertex_found) //viene posto a true in scan
      {
        //aggiungo nodo solo quando trovo un nuovo vertice
        //funzione che aggiunge il vertice eventualmente trovato ai links del current node
        make_tree(nodo_corrente); //funzione in 'Grafo'
        //il vertice viene aggiunto solo se non è gia presente
        vertex_found = false; //riporto il flag a false
        num_nodi++;
      }
      print_tree(); //mostro a schermo l'albero

      //PREPARO PER LA FASE DI MOVIMENTO
      //scelgo il vertice successivo
      //ho due opzioni:
      //primo if -> ho trovato il target, imposto le cordinate del target come quelle di arrivo e calcolo le matrici
      //secondo if -> non ho trovato il target ed ho concluso un giro di scansione, calcolo le matrici per spostarmi sul vertice succesivo ed eseguire un altro giro di scanner

      //se il vertice appenna aggiunto è il target
      if (s) //target trovato (sia durante il ciclo di scan che al termine dello stesso)
      {
        //cambia token quando lo scanner trova il target, e lo passa all'else responsabile della fase di movimento
        token = false; //non devo più usare lo scan, ho trovato il target

        j = 0; //parto dal nodo 0 del mio percorso per arrivare al target
        //exploring_node++;
        exploring = exploring_node;
        exploring_node = trova_nodo(exploring);
        nodo_successivo = nodo.get(exploring_node); //prendo l'ultimo nodo appena inserito
        // nodi_visitati_bezier.add(nodo_successivo);
        nodo_successivo.visitato = true; //stiamo visitando il nodo
        //nodi_visitati_bezier.add(nodo_successivo);

        //trova il percorso tra il nodo corrente e il prossimo da visitare (in questo caso il target)
        //percorso = find_path(nodo_corrente, nodo_successivo);//funzione in 'Grafo'

        // coordinate del nodo di partenza
        //x1 = percorso.get(j).x;
        // y1 = percorso.get(j).y;

        // coordinate nodo di partenza
        x1 = nodo_corrente.x;
        y1 = nodo_corrente.y;


        // coordinate del target (punto da raggiungere)
        x2 = xot;
        y2 = yot;

        t = 0;
        ti = t;

        // Calcolati con mathematica
        A = (2*pow(ti, 3)+3*Dt*pow(ti, 2))/(pow(Dt, 3));
        B = -(6*pow(ti, 2)+6*Dt*ti)/(pow(Dt, 3));
        C = (6*ti+3*Dt)/(pow(Dt, 3));
        D = -2/(pow(Dt, 3));
      }

      if (alpha >= 0 && alpha < start_alpha) //se ho completato lo scanner, non ho trovato il target e ho identificato tutti i vertici che vedo
      {
        //ciclo di scan completo => cambia token per muoversi

        token = false; //non eseguo lo scan perchè mi sto spostando su un nodo
        arrived = false; //non ho ancora trovato il tagert

        //inizializza il path una volta che lo scan è finito per preparare il percorso
        j = 0; //parto dal nodo 0 del mio percorso per arrivare al target
        //exploring_node++;
        exploring = exploring_node;
        exploring_node = trova_nodo(exploring);
        nodo_successivo = nodo.get(exploring_node);//prendo l'ultimo nodo appena inserito
        //nodi_visitati_bezier.add(nodo_successivo);
        nodo_successivo.visitato = true; //stiamo visitando il nodo
        nodi_visitati_bezier.add(nodo_successivo);

        /*
        //trova il percorso tra il nodo corrente e il prossimo da visitare
         percorso = find_path(nodo_corrente, nodo_successivo);
         
         // coordinate nodo di partenza
         x1 = percorso.get(j).x;
         y1 = percorso.get(j).y;
         //coordinate nodo di destinazione
         x2 = percorso.get(j+1).x;
         y2 = percorso.get(j+1).y;
         */
        // coordinate nodo di partenza
        x1 = nodo_corrente.x;
        y1 = nodo_corrente.y;
        //coordinate nodo di destinazione
        x2 = nodo_successivo.x;
        y2 = nodo_successivo.y;


        t = 0;
        ti = t;


        A = (2*pow(ti, 3)+3*Dt*pow(ti, 2))/(pow(Dt, 3));
        B = -(6*pow(ti, 2)+6*Dt*ti)/(pow(Dt, 3));
        C = (6*ti+3*Dt)/(pow(Dt, 3));
        D = -2/(pow(Dt, 3));
      }
    } else
    {
      //FASE DI MOVIMENTO
      //ho due opzioni:
      //if(!s) -> non ho trovato il target nonostante il giro dello scan siamo completo
      //else -> target trovato

      if (!s)//scan terminato, target non trovato
      {

        if (!arrived)
        {
          print_tree(); //mostro il grafo

          // si muove tra due nodi del grafo tramite legge a minima energia
          float[] new_pos = move(x1, y1, x2, y2); // funzione in 'Grafo'

          // le coordinate di destinazione diventano quelle del robot, che così si sposta lì
          pos_x_r = new_pos[0];
          pos_y_r = new_pos[1];

          float toll2 = 1; //variabile di tolleranza
          //x2 e y2 coordinate nodo destinazione, quello in cui il robot si sta spostando
          //potrebbe essere che per arrivare al mio nodo destinazione ci sia un percorso composto da più nodi
          //se il robot è arrivato a destinazione (nel nodo destinazione), anche se
          //non si sono sovrapposti precisamente, proseguo con il prossimo nodo o se sono arrivata mi fermo e riprendo lo scan
          if (abs(pos_x_r - x2) < toll2 && abs(pos_y_r - y2) < toll2 )
          {
            j++;
            //visito tutti i nodi del mio percorso per arrivare a destinazione
            //if (j < (percorso.size() -1))
            //{

            /* se sono arrivato in un nodo non punto finale del path, inizializzo nuovamente le variabili di definizione traiettoria */
            /*            x1 = percorso.get(j).x;
             y1 = percorso.get(j).y;
             x2 = percorso.get(j+1).x;
             y2 = percorso.get(j+1).y;
             */
            // coordinate nodo di partenza
            x1 = nodo_corrente.x;
            y1 = nodo_corrente.y;
            //coordinate nodo di destinazione
            x2 = nodo_successivo.x;
            y2 = nodo_successivo.y;

            t = 0;
            ti = t;

            A = (2*pow(ti, 3)+3*Dt*pow(ti, 2))/(pow(Dt, 3));
            B = -(6*pow(ti, 2)+6*Dt*ti)/(pow(Dt, 3));
            C = (6*ti+3*Dt)/(pow(Dt, 3));
            D = -2/(pow(Dt, 3));
            //}
            //else if (j == (percorso.size() - 1)) //ultimo nodo del mio percorso
            // {
            // print_tree();

            //se sono arrivato all'ultimo nodo del mio percorso
            //arrived = true (ma è superfluo)

            nodo_corrente = nodo_successivo; //sostituisco la radice del mio albero per iniziare nuovamente un giro di scan

            token = true; //riprendo la fase di scansione
            // }
          }
        }
      } else
      {  // if (s) -> target trovato
        float toll2 = 1;
        arrived = true;

        if (abs(pos_x_r - x2) < toll2 && abs(pos_y_r - y2) < toll2 ) //se sono arrivata al nodo destinazione
        {
          //print_tree();
          sembezier = true;
/*
          t = 0;
          ti = t;

          A = (2*pow(ti, 3)+3*Dt*pow(ti, 2))/(pow(Dt, 3));
          B = -(6*pow(ti, 2)+6*Dt*ti)/(pow(Dt, 3));
          C = (6*ti+3*Dt)/(pow(Dt, 3));
          D = -2/(pow(Dt, 3));
*/
          bezier_function();
        } 
        else
        {
          print_tree();
          // x2, y2 sono le coordinate del target
          float[] new_pos = move(x1, y1, x2, y2);
          // spostamento robot nel punto del target
          pos_x_r = new_pos[0];
          pos_y_r = new_pos[1];


          //disegno bezier

          //println("numero nodi :", nodi_visitati_bezier.size(), "----------------------------------------------------");
          for (Nodo n : nodi_visitati_bezier ) //per ogni nodo in cui è passato il robot
          {
            stroke(255);

            //println(n.label);
          }
          //println("numero nodi contati",num_nodi);
          int contatore = 0;


          //println("-----------");
          for (Nodo n : nodi_visitati_bezier )
          {
            stroke(255);
            strokeWeight(5);
            if (contatore < nodi_visitati_bezier.size()-1) //se non è l'ultimo nodo
            {
              nodo_successivo = nodi_visitati_bezier.get(contatore+1); //prendo il nodo successivo
              //println(contatore, "<", nodi_visitati_bezier.size());
              //println(n.label, "->", nodo_successivo.label);
              line(n.x, n.y, nodo_successivo.x, nodo_successivo.y);
            } else
            {
              //println(n.label, "-> target");
              line(n.x, n.y, xot, yot);
            }

            contatore++;
          }
          strokeWeight(2);
          //sembezier = true;
        }
      }
    }
  }

  //if (sembezier) bezier();
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
