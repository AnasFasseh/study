import { useState } from "react";
import useAPI from "./hooks/useAPI";
function App() {
  // const [eleves, setEleves] = useAPI();
  const eleves = useAPI();
  const [code, setCode] = useState("");
  const [nom, setNom] = useState("");
  const [age, setAge] = useState("");
  const [groupe, setGroupe] = useState("");
  const [feleves, setFeleves] = useState(eleves);
  const [test, setTest] = useState(true);

  function handlerClick() {
    const elvs = eleves.filter((elv) => elv.code === parseInt(code));
    const eleve = elvs[0];
    setFeleves(elvs);
    if (eleve) {
      setNom(eleve.nom);
      setAge(eleve.age);
      setGroupe(eleve.Groupe);
    } else {
      setNom("");
      setAge("");
      setGroupe("");
      alert("Ce code n'existe pas!");
    }
    setTest(false)
  }
  function filtrer() {
    const elvs = eleves.filter((elv) => elv.Groupe === groupe);
    setFeleves(elvs);
    setTest(false);
  }
  return (
    <div>
      <h1>Nombre d'élèves {eleves.length}</h1>
      <form onSubmit={(e) => e.preventDefault()}>
        <p>
          Code:
          <input
            type="text"
            value={code}
            onChange={(e) => setCode(e.target.value)}
          />
        </p>
        <p>
          Nom:
          <input
            type="text"
            value={nom}
            onChange={(e) => setNom(e.target.value)}
          />
        </p>
        <p>
          Age:
          <input
            type="text"
            value={age}
            onChange={(e) => setAge(e.target.value)}
          />
        </p>
        <p>
          Groupe:
          <input
            type="text"
            value={groupe}
            onChange={(e) => setGroupe(e.target.value)}
          />
        </p>
        <button onClick={() => handlerClick()}>Rechercher</button>
        <button onClick={() => filtrer()}>Filtrer</button>
        <button onClick={() => setFeleves(eleves)}>Initialiser</button>
      </form>
      <table border="1">
        <tr>
          <th>Code</th>
          <th>Nom</th>
          <th>Age</th>
          <th>Groupe</th>
        </tr>
        {test
          ? eleves.map((eleve, index) => (
              <tr key={index}>
                <td>{eleve.code}</td>
                <td>{eleve.nom}</td>
                <td>{eleve.age}</td>
                <td>{eleve.Groupe}</td>
              </tr>
            ))
          : feleves.map((eleve, index) => (
              <tr key={index}>
                <td>{eleve.code}</td>
                <td>{eleve.nom}</td>
                <td>{eleve.age}</td>
                <td>{eleve.Groupe}</td>
              </tr>
            ))}
      </table>
    </div>
  );
}
export default App;
