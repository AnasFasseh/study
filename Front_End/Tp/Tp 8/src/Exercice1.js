import { useState, useEffect } from "react";
import axios from "axios";

export default function Exercice1() {
  const [count, setCount] = useState(0);
  const [code, setCode] = useState("");
  const [eleves, setEleves] = useState([]);
  const [formData, setFormData] = useState({ Name: "", Age: "", Group: "" });

  const handleChange = (event) => {
    setCode(event.target.value);
  };

  useEffect(() => {
    axios
      .get("https://run.mocky.io/v3/61c41eaf-a507-4d03-84d4-c9c08698703d")
      .then((res) => {
        setCount(res.data.length);
        setEleves(res.data);
      });
  }, []);

  const handleSubmit = (event) => {
    event.preventDefault();
    const eleve = eleves.find((e) => e.code === code);
    if (eleve) {
      setFormData(eleve);
    } else {
      alert("ce code invalide");
    }
  };

  return (
    <form>
      <h2>Nombre d'élèves: {count}</h2>
      <div>
        <label>Code: </label>
        <input name="code" value={code} onChange={handleChange} />
      </div>
      <div>
        <label>Nom: </label>
        <input name="nom" value={formData.Name} />
      </div>
      <div>
        <label>Age: </label>
        <input name="age" value={formData.Age} />
      </div>
      <div>
        <label>Groupe: </label>
        <input name="group" value={formData.Group} />
      </div>
      <button onClick={handleSubmit}>Rechercher</button>
    </form>
  );
}
