package com.music.entity;


import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class User {
	@Id
	private String username;
	private String name;
	private String email;
	private String phone;
	private String password;
	
	private String billAddress;
	private String billCity;
	private String billState;
	private String billCountry;
	private String billZipcode;
	
	private String shipAddress;
	private String shipCity;
	private String shipState;
	private String shipCountry;
	private String shipZipcode;
}
