package com.music.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.music.entity.User;

public interface UserDAO extends JpaRepository<User, String>{

}
