// Legge a minima energia per lo spostamento tra un punto e il successivo
float tempo = 0, tempoi = 0, ppx=pos_x_r, ppy=pos_y_r;
int bez = 0, num_nodi_b = 0;
ArrayList<Float> punti_bezier = new ArrayList<Float>();
boolean sembezier = false;
Nodo terzo_nodo;

void bezier_function ()
{
  float q_t = 0;
  num_nodi_b = nodi_visitati_bezier.size(); // conta da 1 e non da 0
  bez = 0;
  
  noFill();
  bezierDetail(50);
  stroke(0, 0, 255); // blu
  if (num_nodi_b == 1) //c'è solo source e trova subito target
  {
    println("Prima line", root.x, root.y, ppx, ppy);
    bezier(root.x, root.y, xot, yot, xot, yot, xot, yot);

    // Disegna i punti di controllo
    stroke(255, 0, 0); // Rosso
    pushMatrix();
    translate(root.x, root.y);
    sphere(7);
    popMatrix();
    ellipse(root.x, root.y, 8, 10);
    ellipse(xot/4, yot/4, 8, 10);
    ellipse(xot/2, yot/2, 8, 10);
    ellipse(xot, yot, 8, 10);
    stroke(0, 0, 255); // blu
  } else //c'è almeno un nodo in più oltre source
  {
    //println(bez, "line");
    //for (Nodo n : nodi_visitati_bezier)
    for (int i= 0; i<num_nodi_b-1; i=i+1)
    {
      nodo_corrente = nodi_visitati_bezier.get(i);
      nodo_successivo = nodi_visitati_bezier.get(i+1);
   //   terzo_nodo = nodi_visitati_bezier.get(i+2);
      println("NODO ", i, "-------------------------");
      //bezier(nodo_corrente.x, nodo_corrente.y, nodo_successivo.x-30, nodo_successivo.y-30, nodo_successivo.x+30, nodo_successivo.y+30, terzo_nodo.x, terzo_nodo.y);
      bezier(nodo_corrente.x, nodo_corrente.y, nodo_successivo.x-50, nodo_successivo.y-50, nodo_successivo.x-50, nodo_successivo.y-50, nodo_successivo.x, nodo_successivo.y);

      // Disegna i punti di controllo
      stroke(255, 0, 0); // Rosso
      pushMatrix();
      translate(nodo_corrente.x, nodo_corrente.y);
      sphere(7);
      popMatrix();
      ellipse(nodo_corrente.x, nodo_corrente.y, 8, 10);
      ellipse(nodo_successivo.x/4, nodo_successivo.y/4, 8, 10);
      ellipse(nodo_successivo.x/2, nodo_successivo.y/2, 8, 10);
      ellipse(nodo_successivo.x, nodo_successivo.y, 8, 10);
      stroke(0, 0, 255); // blu


      //bez ++;
    }
    //ultimo collegamento con target
    terzo_nodo = nodi_visitati_bezier.get(num_nodi_b-1);
    //bezier(terzo_nodo.x, terzo_nodo.y, terzo_nodo.x+30, terzo_nodo.y+30, terzo_nodo.x-30, terzo_nodo.y-30, xot, yot);
    bezier(terzo_nodo.x, terzo_nodo.y, terzo_nodo.x+30, terzo_nodo.y+30, xot-30, yot-30, xot, yot);

    // Disegna i punti di controllo
    stroke(255, 0, 0); // Rosso
    pushMatrix();
    translate(root.x, root.y);
    sphere(7);
    popMatrix();
    ellipse(root.x, root.y, 8, 10);
    ellipse(xot/4, yot/4, 8, 10);
    ellipse(xot/2, yot/2, 8, 10);
    ellipse(xot, yot, 8, 10);
    stroke(0, 0, 255); // blu
  }
}

int binomio(int n, int k) {
  if (k < 0 || k > n) {
    return 0;
  }
  int[][] dp = new int[n + 1][k + 1];
  for (int i = 0; i <= n; i++) {
    for (int j = 0; j <= min(i, k); j++) {
      if (j == 0 || j == i) {
        dp[i][j] = 1;
      } else {
        dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j];
      }
    }
  }
  return dp[n][k];
}


/*
float q_t = 0;
 num_nodi_b = nodi_visitati_bezier.size()-1; //-1 perchè conta da 1 e non da 0
 bez = 0;
 
 stroke(0, 0, 255);
 
 for (Nodo n : nodi_visitati_bezier)
 {
 println("NODO ", bez, "-------------------------");
 q_t = 0;
 for (int i=0; i<40; i++)
 {
 // Polinomio di ordine tre per avere l'ottimo nel caso a minima energia
 //q_t = A*pow(t, 3) + B*pow(t, 2) + C*t + D;
 q_t = q_t + 0.025;
 //println("q -> ", q_t);
 
 
 //x
 ppx = ppx + n.x * binomio(num_nodi_b, bez) * pow(1-q_t, num_nodi_b -bez) * pow(q_t, bez);
 punti_bezier.add(ppx);
 //y
 ppy = ppy + n.y * binomio(num_nodi_b, bez) * pow(1-q_t, num_nodi_b -bez) * pow(q_t, bez);
 punti_bezier.add(ppy);
 
 stroke(0, 0, 255); // blu
 //if (bez == 0)
 if (num_nodi_b == 0) //c'è solo source e trova subito target
 {
 println("Prima line", root.x, root.y, ppx, ppy);
 //line(root.x, root.y, ppx, ppy);
 //bezier(root.x, root.y, ppx/2, ppy/2,ppx/2,ppy/2,ppx,ppy);
 //bezier(root.x, root.y, n.x/4, n.y/4, n.x/2, n.y/2, n.x, n.y);
 bezier(root.x, root.y, xot/4, yot/4, xot/2, yot/2, xot, yot);
 //bezierVertex(root.x, root.y, ppx/2, ppy/2, ppx, ppy);
 
 // Disegna i punti di controllo
 stroke(255, 0, 0); // Rosso
 pushMatrix();
 translate(root.x, root.y);
 sphere(7);
 popMatrix();
 ellipse(root.x, root.y, 8, 10);
 ellipse(xot/4, yot/4, 8, 10);
 ellipse(xot/2, yot/2, 8, 10);
 ellipse(xot, yot, 8, 10);
 stroke(0, 0, 255); // blu
 }
 else //c'è almeno un nodo in più oltre source
 {
 println(bez, "line");
 //line(punti_bezier.get(bez-1), punti_bezier.get(bez-1), ppx, ppy);
 //bezier(punti_bezier.get(bez-1), punti_bezier.get(bez-1), ppx, ppy);
 }
 }
 
 bez ++;
 
 
 */
