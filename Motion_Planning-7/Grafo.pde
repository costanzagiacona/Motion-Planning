void make_tree(Nodo current) {

  int s = nodo.size();
  String s_lab = String.valueOf(s);
  float toll = r_r;

  Nodo n = new Nodo(s_lab, x_vert, y_vert);
  

  for (Nodo ni : nodo) {

    if (abs(ni.x -x_vert)< toll && abs(ni.y-y_vert)<toll) {
      //se già esiste, o se è sufficientemente vicino ad un vertice già esistente
      //tree.linknodo(ni, current);   //se il nodo è già "presente", crea solo arco
      return;
    }
  }
  albero.addChild(current, n);
}

void print_tree() {

  float x_c  = albero.radice.x;
  float y_c = albero.radice.y;
  
  fill(#EFF54F);
  stroke(#EFF54F);
  translate(0, 0, 2);
  circle(x_c, y_c, 40);
  translate(0, 0, -2);

  if (print) {
    for (Nodo ni : nodo) {

      strokeWeight(5);
      fill(#4BA240);
      stroke(#4BA240);

      circle(ni.x, ni.y, r_nodo);
      fill(0);

      if (label_print) {
        translate(0, 0, 20);
        textSize(30);
        text(ni.label, ni.x, ni.y);
        translate(0, 0, -20);
      }

      for (Nodo near : ni.links) {
        strokeWeight(1);
        line(ni.x, ni.y, near.x, near.y);
      }

      if (s) {
        line(nodo_corrente.x, nodo_corrente.y, xot, yot );
      }
    }
  }
}


/*la funzione find_path cerca primo antenato comune tra due nodi, e in particolare ne riporta un ArrayList contenente tutti i nodi
 che costituiscono il cammino per andare dal nodo source al nodo destination, passando al più per la root dell'albero */


ArrayList<Nodo> find_path(Nodo source, Nodo dest) {

  ArrayList<Nodo> path = new ArrayList<Nodo>();

  boolean exit = false;
  Nodo source_var = source;

  ArrayList<Nodo> s_path = new ArrayList<Nodo>();
  ArrayList<Nodo> d_path = new ArrayList<Nodo>();


  if (source.padre != dest && dest.padre != source) {
    while (source_var != albero.radice && exit == false) {

      Nodo dest_var = dest;
      d_path.removeAll(d_path);
      d_path.add(dest_var);

      while (dest_var != albero.radice && exit == false ) {

        if (source_var.padre == dest_var.padre) {
          d_path.add(0, dest_var.padre);

          exit = true;
        } else {
          d_path.add(0, dest_var.padre);
          dest_var = dest_var.padre;
        }
      }

      s_path.add(source_var);

      source_var = source_var.padre;
    }

    s_path.addAll(d_path);
    path = s_path;
  } else {

    path.add(source);
    path.add(dest);
  }

  
  return path;
}


float[] move(float x1, float y1, float x2, float y2) {

  float[] new_pos = {x1, y1};

  /*  IMPLEMENTAZIONE LEGGE ORARIA */

  float q_t = A*pow(t, 3) + B*pow(t, 2) + C*t + D;

  new_pos[0] = x1 + q_t*(x2-x1);
  new_pos[1] = y1 + q_t*(y2-y1);


  return new_pos;
}
