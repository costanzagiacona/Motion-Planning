// Legge a minima energia per lo spostamento tra un punto e il successivo
float tempo = 0, tempoi = 0, ppx=pos_x_r, ppy=pos_y_r;
int bez = 0, num_nodi_b = 0;
ArrayList<Float> punti_bezier = new ArrayList<Float>();
boolean sembezier = false;
Nodo terzo_nodo;

void bezier_function(float A, float B, float C, float D)
{
  num_nodi_b = nodi_visitati_bezier.size(); // conta da 1 e non da 0
  float c1, c2, c3, c4;  // coordinate punti di controllo
  float ai = 0.8;        // parametro u di controllo
  Nodo nodo_inter = new Nodo("inter", 0, 0, 0);  // nodo intermedio tra P0 e P2 per calcolare coordinate di controllo

  noFill();
  //bezierDetail(50);
  stroke(0, 0, 255); // blu
  if (num_nodi_b == 1) //c'è solo source e trova subito target
  {
    //println("Prima line", root.x, root.y, ppx, ppy);

    // Calcolo coordinate punto di controllo P01
    c1 = root.x*(1 - ai) + xot*ai;  // x
    c2 = root.y*(1 - ai) + yot*ai;  // y
    // Calcolo coordinate punto di controllo P01
    c3 = xot*(1-ai) + root.x*ai;    // x
    c4 = yot*(1-ai) + root.y*ai;    // y


    //bezier(root.x, root.y, xot, yot, xot, yot, xot, yot);
    bezier(root.x, root.y, c1, c2, c3, c4, xot, yot);  // punti: ancoraggio, controllo, controllo, ancoraggio

    /*    // Disegna i punti di controllo
     stroke(255, 0, 0); // Rosso
     pushMatrix();
     translate(root.x, root.y);
     sphere(7);
     popMatrix();
     ellipse(root.x, root.y, 8, 10);
     ellipse(xot/4, yot/4, 8, 10);
     ellipse(xot/2, yot/2, 8, 10);
     ellipse(xot, yot, 8, 10);*/
    stroke(0, 0, 255); // blu
  } else //c'è almeno un nodo in più oltre source
  {
    //println(bez, "line");
    for (int i= 0; i<num_nodi_b-1; i++)
    {
      nodo_corrente = nodi_visitati_bezier.get(i);
      nodo_successivo = nodi_visitati_bezier.get(i+1);

      // calcolo coordinate punto intermedio P1
      nodo_inter.x = (nodo_corrente.x + nodo_successivo.x)/2;
      nodo_inter.y = 2*(nodo_corrente.y + nodo_successivo.y)/3;

      // Calcolo coordinate punto di controllo P01
      c1 = nodo_corrente.x*(1-ai) + nodo_inter.x*ai;    // x
      c2 = nodo_corrente.y*(1-ai) + nodo_inter.y*ai;    // y
      // Calcolo coordinate punto di controllo P11
      c3 = nodo_inter.x*(1-ai) + nodo_successivo.x*ai;  // x
      c4 = nodo_inter.y*(1-ai) + nodo_successivo.y*ai;  // y

      //println(ai, c1, c2, c3, c4);

      //println("NODO ", i);
      bezier(nodo_corrente.x, nodo_corrente.y, c1, c2, c3, c4, nodo_successivo.x, nodo_successivo.y);

      // Disegna i punti di controllo
      //stroke(255, 0, 0); // Rosso
      //pushMatrix();
      //translate(nodo_corrente.x, nodo_corrente.y);
      //sphere(7);
      //popMatrix();
      //ellipse(nodo_inter.x, nodo_inter.y, 8, 10);
      //ellipse(nodo_corrente.x, nodo_corrente.y, 8, 10);
      //ellipse(nodo_corrente.x/1.2, nodo_corrente.y/1.2, 8, 10);
      //ellipse(nodo_successivo.x/1.2, nodo_successivo.y/1.2, 8, 10);
      //ellipse(nodo_successivo.x, nodo_successivo.y, 8, 10);
      stroke(0, 0, 255); // blu
    }

    // ultimo collegamento con target
    nodo_corrente = nodi_visitati_bezier.get(num_nodi_b-1);
    // punto intermedio di controllo
    nodo_inter.x = (nodo_corrente.x + xot)/2;
    nodo_inter.y = 2*(nodo_corrente.y + yot)/3;

    //println("NODO ", i);

    // Calcolo coordinate punto di controllo P01
    c1 = nodo_corrente.x*(1-ai) + nodo_inter.x*ai;
    c2 = nodo_corrente.y*(1-ai) + nodo_inter.y*ai;
    // Calcolo coordinate punto di controllo P11
    c3 = nodo_inter.x*(1-ai) + xot*ai;
    c4 = nodo_inter.y*(1-ai) + yot*ai;

    //println(ai, c1, c2, c3, c4);

    // Disegno curva di Bezier tra ultimo nodo e target
    bezier(nodo_corrente.x, nodo_corrente.y, c1, c2, c3, c4, xot, yot);

    /*    // Disegna i punti di controllo
     stroke(255, 0, 0); // Rosso
     pushMatrix();
     translate(root.x, root.y);
     sphere(7);
     popMatrix();
     ellipse(root.x, root.y, 8, 10);
     ellipse(xot/4, yot/4, 8, 10);
     ellipse(xot/2, yot/2, 8, 10);
     ellipse(xot, yot, 8, 10);*/
    stroke(0, 0, 255); // blu
  }
}

int binomio(int n, int k)
{
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
