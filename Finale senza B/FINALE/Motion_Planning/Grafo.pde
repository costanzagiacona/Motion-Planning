// costruisce l'albero aggiungendo il nodo corrente
void make_tree(Nodo current) {

  int s = nodo.size();
  int id_vert = s;
  String s_lab = String.valueOf(s);
  float toll = 25; 
  //float toll = 12;

  Nodo n = new Nodo(s_lab, x_vert, y_vert, id_vert);  // ogni nodo ha label e coordinate (x,y)

  for (Nodo ni : nodo) {
    if (abs(ni.x-x_vert) < toll && abs(ni.y-y_vert) < toll) {
      //se già esiste, o se è sufficientemente vicino ad un vertice già esistente
      return;
    }
  }
  albero.addChild(current, n);
}


// visualizza a schermo l'albero
void print_tree()
{
  float x_c  = albero.radice.x;
  float y_c = albero.radice.y;

  fill(#EFF54F);
  stroke(#EFF54F);
  translate(0, 0, 2);
  circle(x_c, y_c, 40);
  translate(0, 0, -2);

  if (print)
  {
    for (Nodo ni : nodo) // per ogni nodo nel grafo
    {
      strokeWeight(5);
      fill(#4BA240);
      stroke(#4BA240);
      circle(ni.x, ni.y, r_nodo);
      fill(0);

      if (label_print) // stampa label
      {
        translate(0, 0, 20);
        textSize(30);
        text(ni.label, ni.x, ni.y);
        translate(0, 0, -20);
      }

      for (Nodo near : ni.links) // disegna arco tra nodo corrente (ni) e quelli adiacenti (near)
      {
        strokeWeight(1); // spessore arco
        line(ni.x, ni.y, near.x, near.y);
      }

      if (s) // se target trovato
      {
        line(nodo_corrente.x, nodo_corrente.y, xot, yot );  // disegna arco tra posizione corrente robot e target
      }
    }
  }
  strokeWeight(3); //reinserisco la dimensione dei lati altrimenti il tavolo viene disegnato più spesso
}

//VISITA IN PROFONDITA'
/* Calcola la distanza tra il robot e tutti i nodi (tranne quelli già visitati)
 in modo da trovare il nodo più vicino
 */
int trova_nodo(int exploring_node) //ci passiamo a che nodo siamo
{
  float min = 0;
  float distanza = 0;
  int id_min = -1;
  Nodo n1 = nodo.get(exploring_node); //prendiamo il nodo corrente

  distanza = 6000000; //numero grande
  min = distanza;

  for (Nodo n : n1.links) //controlliamo tra i figli
  {
    if (!n.visitato)
    {
      distanza = sqrt(pow(pos_x_r - n.x, 2) + pow(pos_y_r - n.y, 2)); //distanza tra il robot e il nodo
      if (distanza < min && distanza > 0) //se mi trovo su quel nodo ho distanza 0
      {
        min = distanza;
        id_min = n.id; //salviamo id del nodo più vicino
      }
    }
  }

  //se non trova figli torna al padre
  if (id_min == -1)
  {
    //println("Non ho figli vicini, torno dal padre");
    id_min = nodo.get(exploring_node).padre.id;
  }

  //println("Nodo più vicino ->", id_min);
  return id_min;
}

// Legge a minima energia per lo spostamento tra un punto e il successivo
float[] move(float x1, float y1, float x2, float y2)
{
  float[] new_pos = {x1, y1};

  /*  IMPLEMENTAZIONE LEGGE ORARIA */

  // Polinomio di ordine tre per avere l'ottimo nel caso a minima energia
  float q_t = A*pow(t, 3) + B*pow(t, 2) + C*t + D;

  // coordinate in cui si sposta il robot e da cui farà di nuovo scan
  new_pos[0] = x1 + q_t*(x2-x1);
  new_pos[1] = y1 + q_t*(y2-y1);

  return new_pos;
}
