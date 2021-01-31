package com.music.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.music.entity.Music;

public interface MusicDAO extends JpaRepository<Music, String>{
	
}
