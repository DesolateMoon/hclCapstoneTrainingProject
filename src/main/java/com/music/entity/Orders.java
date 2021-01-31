package com.music.entity;

import java.util.Optional;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
public class Orders {
	private Optional<Music> productname;
	private int quantity;
	
	public Optional<Music> getProductname() {
		return productname;
	}
	public void setProductname(Optional<Music> productname) {
		this.productname = productname;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
