// Legge a minima energia per lo spostamento tra un punto e il successivo
float tempo = 0, tempoi = 0, ppx=pos_x_r, ppy=pos_y_r;
int bez = 0, num_nodi_b = 0;
ArrayList<Float> punti_bezier = new ArrayList<Float>();
boolean sembezier = false;
Nodo terzo_nodo;

void bezier_function()
{
  num_nodi_b = nodi_visitati_bezier.size(); // conta da 1 e non da 0
  float a1, b1, c1, d1;  // coordinate punti di controllo
  nodo_successivo = nodi_visitati_bezier.get(1);
  a1 = (root.x + nodo_successivo.x)/2 + 15;
  b1 = (root.y + nodo_successivo.y)/2 + 15;

  //stroke(255, 0, 0);
  //ellipse(a1, b1, 8, 10);
  //bezier(root.x, root.y, a1, b1, a1, b1, nodo_successivo.x, nodo_successivo.y);

  noFill();
  //bezierDetail(50);
  stroke(0, 0, 255); // blu
  if (num_nodi_b == 1) //c'è solo source e trova subito target
  {
    //println("Prima line", root.x, root.y, ppx, ppy);
    c1 = -a1 + (2*xot);
    d1 = -b1 + (2*yot);

    //bezier(root.x, root.y, xot, yot, xot, yot, xot, yot);
    bezier(root.x, root.y, c1, d1, c1, d1, xot, yot);  // punti: ancoraggio, controllo, controllo, ancoraggio

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
    for (int i = 0; i < num_nodi_b-1; i++)
    {
      nodo_corrente = nodi_visitati_bezier.get(i);
      nodo_successivo = nodi_visitati_bezier.get(i+1);

      c1 = -a1 + (2*nodo_successivo.x);
      d1 = -b1 + (2*nodo_successivo.y);

      //if (c1 >= posxsp[nfigurasp])
      //{
      //  c1 = posxsp[nfigurasp];
      //} else if(c1 <= -posxsp[nfigurasp]) {
      //  c1 = posxsp[nfigurasp];
      //}
      //if (d1 >= posysp[nfigurasp])
      //{
      //  d1 = posysp[nfigurasp];
      //} else if (d1 <= -posysp[nfigurasp]){
      //  d1 = -posysp[nfigurasp];
      //}

      //println("NODO ", i);
      bezier(nodo_corrente.x, nodo_corrente.y, c1, d1, c1, d1, nodo_successivo.x, nodo_successivo.y);
      for (float l = 0; l < 1; l = l+0.01) {
        float x = pow((1-l), 2)*nodo_corrente.x+2*(1-l)*l*a1+pow(l, 2)*nodo_successivo.x;
        float y = pow((1-l), 2)*nodo_corrente.y+2*(1-l)*l*b1+pow(l, 2)*nodo_successivo.y;

        stroke(255);
        point(x, y);
      }
      a1 = c1;
      b1 = d1;
      // Disegna i punti di controllo
      //stroke(255, 0, 0); // Rosso
      //pushMatrix();
      //translate(nodo_corrente.x, nodo_corrente.y);
      //sphere(7);
      //popMatrix();
      stroke(255);
      ellipse(c1, d1, 8, 10);
      stroke(0, 0, 255); // blu
    }

    // ultimo collegamento con target
    nodo_corrente = nodi_visitati_bezier.get(num_nodi_b-1);

    //println("NODO ", i);

    c1 = -a1 + (2*xot);
    d1 = -b1 + (2*yot);
    // Disegno curva di Bezier tra ultimo nodo e target
    for (float l = 0; l < 1; l = l+0.01) {
      float x = pow((1-l), 2)*nodo_corrente.x+2*(1-l)*l*a1+pow(l, 2)*xot;
      float y = pow((1-l), 2)*nodo_corrente.y+2*(1-l)*l*b1+pow(l, 2)*yot;

      stroke(255);
      point(x, y);
    }
    stroke(0, 0, 255);
    bezier(nodo_corrente.x, nodo_corrente.y, c1, d1, c1, d1, xot, yot);

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
