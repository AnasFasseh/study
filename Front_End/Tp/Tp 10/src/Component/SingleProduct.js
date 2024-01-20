import React, { useEffect, useState } from "react";
import { products_list } from "./products_list";
import { Link, useParams } from "react-router-dom";
import ProductCard from "./ProductCard";
export default function SingleProduct() {
  const { id } = useParams();
  const [data, setData] = useState({});
  useEffect((_) => {
    setData(...products_list.filter((el) => el.id == id));
  }, []);
  return (
    <div className="d-flex justify-content-center mt-4 flex-column">
      {data ? (
        <ProductCard
          src={data.thumbnail}
          title={data.title}
          price={data.price}
          width={350}
        />
      ) : (
        <p className="alert alert-danger">This Product Doesnt Exist !</p>
      )}
      <Link to="/">Retour à la page d'acceuil</Link>
    </div>
  );
}
