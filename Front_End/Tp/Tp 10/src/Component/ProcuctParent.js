import React from "react";
import ProductCard from "./ProductCard";
import { products_list } from "./products_list";
export default function ProcuctParent() {
  return (
    <div className="container mt-4" style={{display:'grid',gap : '14px',gridTemplateColumns:'repeat(4,1fr)'}}>
      {products_list.map((ele) => (
        <ProductCard
          id={ele.id}
          src={ele.thumbnail}
          title={ele.title}
          price={ele.price}
          key={ele.id}
        />
      ))}
    </div>
  );
}