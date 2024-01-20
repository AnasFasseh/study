import React, { useState } from "react";
import "./form1.css";
const authentification = {
  user: "anas",
  password: "123",
};
function Form1() {
  const [formData, setFormData] = useState({
    user: "",
    password: "",
  });
  const [userError, setUserError] = useState("");
  const [passError, setPassError] = useState("");
  const [card, setCard] = useState(false);

  const handlerChange = (event) => {
    setFormData((oldState) => {
      return {
        ...oldState,
        [event.target.name]: event.target.value,
      };
    });
  };

  const handlerSubmit = (event) => {
    event.preventDefault();
    if (formData.user === authentification.user) {
      if (formData.password !== authentification.password) {
        setPassError("Votre mot de passe est incorrect");
        setUserError("");
      } else {
        setPassError("");
        setUserError("");
        setCard((old) => !old);
      }
    } else {
      if (formData.password !== authentification.password) {
        setPassError("Votre mot de passe est incorrect");
        setUserError("Votre identifient est incorrect");
      } else {
        setUserError("Votre identifient est incorrect");
        setPassError("");
      }
    }
  };
  return (
    <div>
      {card ? (
        <div className="card">
          <h2>Accueil</h2>
          <p>Bonjour {formData.user}</p>
        </div>
      ) : (
        <form onSubmit={handlerSubmit} className="form-login">
          <div>
            <h2>Connexion</h2>
          </div>
          <div className="inputs-container">
            <label>L'identifiant : </label>
            <br />
            <input
              name="user"
              value={formData.user}
              onChange={handlerChange}
              placeholder="Enter your Identifier"
            />
            <span>{userError}</span>
          </div>

          <div className="inputs-container">
            <label>Mot de passe : </label>
            <br />
            <input
              name="password"
              value={formData.password}
              onChange={handlerChange}
              placeholder="Enter your Password"
            />
            <span>{passError}</span>
          </div>
          <div>
            <button>Se connecter</button>
          </div>
        </form>
      )}
    </div>
  );
}

export default Form1;
