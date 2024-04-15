// Legge a minima energia per lo spostamento tra un punto e il successivo
float tempo = 0, tempoi = 0, ppx=pos_x_r, ppy=pos_y_r;
int bez = 0, num_nodi_b = 0;
ArrayList<Float> punti_bezier = new ArrayList<Float>();
boolean sembezier = false;

void bezier ()
{
  float q_t = 0;
  num_nodi_b = nodi_visitati_bezier.size()-1; //-1 perchè conta da 1 e non da 0
  bez = 0;

  stroke(0, 0, 255);

  for (Nodo n : nodi_visitati_bezier)
  {
    // Polinomio di ordine tre per avere l'ottimo nel caso a minima energia
    q_t = A*pow(t, 3) + B*pow(t, 2) + C*t + D;

    //x
    ppx = ppx + n.x * binomio(num_nodi_b, bez) * pow(1-q_t, num_nodi_b -bez) * pow(q_t, bez);
    punti_bezier.add(ppx);
    //y
    ppy = ppy + n.y * binomio(num_nodi_b, bez) * pow(1-q_t, num_nodi_b -bez) * pow(q_t, bez);
    punti_bezier.add(ppy);

    if (bez == 0)
    {
      println("Prima line",root.x, root.y, ppx, ppy);
      line(root.x, root.y, ppx, ppy);
    } 
    else
    {
      println(bez, "line");
      line(punti_bezier.get(bez-1), punti_bezier.get(bez-1), ppx, ppy);
    }

    bez ++;
  }

  //dall'ultimo vertice al target
  
  line(ppx, ppy, xot, yot);
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
