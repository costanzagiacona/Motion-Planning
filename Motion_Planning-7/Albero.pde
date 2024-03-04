class Albero  
{
  Nodo radice; //radice albero

  // costruttore della classe Albero
  Albero(Nodo r) 
  {
    radice = r;
    nodo.add(radice); //inizializzato in MP 5
  }
 
 // aggiunge il nodo all'albero
  void addNodo(Nodo nodo1) 
  {
    if (!nodo.contains(nodo1)) 
    {
      nodo.add(nodo1);
    }
  }
 
 // rimuove il nodo dall'albero
  void rimuovoNodo(int index)
  {
    Nodo n = nodo.get(index);
    for (Nodo linked_node_i : n.getIncomingLinks()){
      linked_node_i.getIncomingLinks().remove(n);
    }
    nodo.remove(index);
  }
  
  Nodo getRoot() {
    return radice;
  }
  
  int size() {
    return nodo.size();
  }
  
  // restituisce il nodo identificato dal suo indice
  Nodo getNode(int index) {
    return nodo.get(index);
  }
  
  ArrayList<Nodo> getNodes() {
    return nodo;
  }
  
  // aggiunge un arco tra due nodi
  boolean linkNodes(Nodo n1, Nodo n2) {
    if (nodo.contains(n1) && nodo.contains(n2)) {
      n1.addLink(n2);
      n2.addLink(n1);
      return true;
    }
    return false;
  }

  // aggiunge il nodo child come figlio di parent
  void addChild(Nodo parent, Nodo child) 
  {
    nodo.add(child);
    child.padre = parent;
    linkNodes(parent, child);
  }
  
}
