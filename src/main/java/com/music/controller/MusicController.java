package com.music.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.music.dao.MusicDAO;
import com.music.dao.UserDAO;
import com.music.entity.Music;
import com.music.entity.Orders;
import com.music.entity.User;

@RestController
public class MusicController {
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private MusicDAO musicDAO;
	
	@GetMapping("")
	public ModelAndView displayMainPage() {
		return new ModelAndView("main");
	}
	
	@GetMapping("/register")
	public ModelAndView displayRegisterUserPage() {
		return new ModelAndView("register");
	}
	
	@PostMapping("/register")
	public ModelAndView addUser(@RequestParam("username") String username,
							    @RequestParam("name") String name,
								@RequestParam("email") String email,
								@RequestParam("phone") String phone,
								@RequestParam("password") String password,
								@RequestParam("billAddress") String billAddress,
								@RequestParam("billCity") String billCity,
								@RequestParam("billState") String billState,
								@RequestParam("billCountry") String billCountry,
								@RequestParam("billZipcode") String billZipcode,
								@RequestParam("shipAddress") String shipAddress,
								@RequestParam("shipCity") String shipCity,
								@RequestParam("shipState") String shipState,
								@RequestParam("shipCountry") String shipCountry,
								@RequestParam("shipZipcode") String shipZipcode) {
		User user = new User(username, name, email, phone, password, 
							 billAddress, billCity, billState, billCountry, billZipcode,
							 shipAddress, shipCity, shipState, shipCountry, shipZipcode);
		userDAO.save(user); 
		return new ModelAndView("main");
	}
	
	@GetMapping("/login")
	public ModelAndView displayLoginPage() {
		return new ModelAndView("login");
	}
	
	@PostMapping("/login")
	public ModelAndView loginUser(@RequestParam("username") String username,
			  					  @RequestParam("password") String password,
			  					  HttpSession session) {
		if(userDAO.existsById(username) && userDAO.findById(username).get().getUsername().equals("admin")) {
			List<User> users = (List<User>)userDAO.findAll();
			for(User u : users) {
				if(u.getName().equals("admin")) {
					users.remove(u);
				}
			}
			session.setAttribute("users", users);
		}
		if(userDAO.existsById(username) && userDAO.findById(username).get().getPassword().equals(password)) {
			session.setAttribute("user", userDAO.findById(username).get());
			return new ModelAndView("main");
		}
		return new ModelAndView("login");
	}
	
	@GetMapping("/logout")
	public ModelAndView logoutUser(HttpSession session) {
		session.setAttribute("user", null);
		session.setAttribute("orders", null);
		session.setAttribute("music", null);
		session.invalidate();
		return new ModelAndView("main");
	}
		
	@GetMapping("/music")
	public ModelAndView displayMusicPage(HttpSession session) {
		List<Music> musics = (List<Music>)musicDAO.findAll();
		session.setAttribute("musics", musics);
		return new ModelAndView("music");
	}
	
	@GetMapping("/music/{productname}")
	public ModelAndView displayMusicInfoPage(@PathVariable("productname") String productname,
											 HttpSession session) {
		Optional<Music> music = musicDAO.findById(productname);
		session.setAttribute("music", music);
		return new ModelAndView("info");
	}
	
	@GetMapping("/cart")
	public ModelAndView displayCartPage() {
		return new ModelAndView("cart");
	}
	
	@GetMapping("/addcart/{productname}")
	public ModelAndView addProductToCart(@PathVariable("productname") String productname,
										 HttpSession session) {
		if(session.getAttribute("orders") == null) {
			ArrayList<Orders> orders = new ArrayList<>();
			Orders order = new Orders(musicDAO.findById(productname), 1);
			orders.add(order);
			session.setAttribute("orders", orders);
		} else {
			ArrayList<Orders> orders = (ArrayList<Orders>) session.getAttribute("orders");
			for(Orders o: orders) {
				if(o.getProductname().get().getProductname().equals(productname)) {
					o.setQuantity(o.getQuantity()+1);
					session.setAttribute("orders", orders);
					return new ModelAndView("music");
				}
			}
			Orders order = new Orders(musicDAO.findById(productname), 1);
			orders.add(order);
			session.setAttribute("orders", orders);
		}
		return new ModelAndView("music");
	}
	
	@GetMapping("/emptycart")
	public ModelAndView emptyCart(HttpSession session) {
		session.setAttribute("orders", null);
		return new ModelAndView("cart");
	}
	
	@GetMapping("/emptycart/{productname}")
	public ModelAndView emptyProductFromCart(@PathVariable("productname") String productname,
											 HttpSession session) {
		ArrayList<Orders> orders = (ArrayList<Orders>) session.getAttribute("orders");
		for(Orders o: orders) {
			if(o.getProductname().get().getProductname().equals(productname)) {
				orders.remove(o);
				break;
			}
		}
		session.setAttribute("orders", orders);
		return new ModelAndView("cart");
	}
	
	@GetMapping("/checkout/billing")
	public ModelAndView displayCustomerBillingDetailsPage() {
		return new ModelAndView("customerbilldetails");
	}
	
	@PostMapping("/checkout/billing")
	public ModelAndView saveCustomerBillingDetails(@RequestParam("name") String name,
												   @RequestParam("email") String email,
												   @RequestParam("phone") String phone,
												   @RequestParam("billAddress") String billAddress,
												   @RequestParam("billCity") String billCity,
												   @RequestParam("billState") String billState,
												   @RequestParam("billCountry") String billCountry,
												   @RequestParam("billZipcode") String billZipcode,
												   HttpSession session) {
		User user = (User) session.getAttribute("user");
		String username = user.getUsername();
		userDAO.findById(username).get().setName(name);
		userDAO.findById(username).get().setEmail(email);
		userDAO.findById(username).get().setPhone(phone);
		userDAO.findById(username).get().setBillAddress(billAddress);
		userDAO.findById(username).get().setBillCity(billCity);
		userDAO.findById(username).get().setBillState(billState);
		userDAO.findById(username).get().setBillCountry(billCountry);
		userDAO.findById(username).get().setBillZipcode(billZipcode);
		user = userDAO.findById(username).get();
		session.setAttribute("user", user);
		return new ModelAndView("customershipdetails");
	}
	
	@GetMapping("/checkout/shipping")
	public ModelAndView displayCustomerShippingDetailsPage() {
		return new ModelAndView("customershipdetails");
	}
	
	@PostMapping("/checkout/shipping")
	public ModelAndView saveCustomerShippingDetails(@RequestParam("name") String name,
												    @RequestParam("email") String email,
												    @RequestParam("phone") String phone,
												    @RequestParam("shipAddress") String shipAddress,
												    @RequestParam("shipCity") String shipCity,
												    @RequestParam("shipState") String shipState,
												    @RequestParam("shipCountry") String shipCountry,
												    @RequestParam("shipZipcode") String shipZipcode,
												    HttpSession session) {
		User user = (User) session.getAttribute("user");
		String username = user.getUsername();
		userDAO.findById(username).get().setName(name);
		userDAO.findById(username).get().setEmail(email);
		userDAO.findById(username).get().setPhone(phone);
		userDAO.findById(username).get().setShipAddress(shipAddress);
		userDAO.findById(username).get().setShipCity(shipCity);
		userDAO.findById(username).get().setShipState(shipState);
		userDAO.findById(username).get().setShipCountry(shipCountry);
		userDAO.findById(username).get().setShipZipcode(shipZipcode);
		user = userDAO.findById(username).get();
		session.setAttribute("user", user);
		return new ModelAndView("confirmation");
	}
	
	@GetMapping("/checkout/confirmation")
	public ModelAndView displayCustomerConfirmationPage() {
		return new ModelAndView("confirmation");
	}
	
	@GetMapping("/checkout/confirmation/success")
	public ModelAndView displayCustomerSuccessConfirmationPage() {
		return new ModelAndView("confirmationsuccess");
	}
	
	@GetMapping("/admin")
	public ModelAndView displayAdminPage() {
		return new ModelAndView("admin");
	}
	
	@GetMapping("/admin/customermanagement")
	public ModelAndView displayCustomerManagementPage() {
		return new ModelAndView("customermanagement");
	}
	
	@GetMapping("/admin/deleteproduct/{productname}")
	public ModelAndView deleteMusic(@PathVariable("productname") String productname,
									HttpSession session) {
		musicDAO.deleteById(productname);
		List<Music> musics = (List<Music>)musicDAO.findAll();
		session.setAttribute("musics", musics);
		return new ModelAndView("music");
	}
	
	@GetMapping("/admin/addproduct")
	public ModelAndView displayAddMusicPage() {
		return new ModelAndView("add");
	}
	
	@PostMapping("/admin/addproduct")
	public ModelAndView addMusic(@RequestParam("productname") String productname,
								 @RequestParam("category") String category,
								 @RequestParam("quality") String quality,
								 @RequestParam("price") String price ,
								 @RequestParam("url") String url,
								 HttpSession session) {
		Music music = new Music(productname, category, quality, price, url);
		musicDAO.save(music);
		List<Music> musics = (List<Music>)musicDAO.findAll();
		session.setAttribute("musics", musics);
		return new ModelAndView("music");
	}
	
	@GetMapping("/admin/editproduct/{product}")
	public ModelAndView displayEditMusicPage(@PathVariable("product") String product,
										     HttpSession session) {
		Optional<Music> music = musicDAO.findById(product);
		session.setAttribute("music", music);
		return new ModelAndView("edit");
	}
	
	@PostMapping("/admin/editproduct/{product}")
	public ModelAndView editMusic(@PathVariable("product") String product,
								  @RequestParam("productname") String productname,
								  @RequestParam("category") String category,
								  @RequestParam("quality") String quality,
								  @RequestParam("price") String price ,
								  @RequestParam("url") String url,
								  HttpSession session) {
		musicDAO.findById(product).get().setProductname(productname);
		musicDAO.findById(product).get().setCategory(category);
		musicDAO.findById(product).get().setQuality(quality);
		musicDAO.findById(product).get().setPrice(price);
		musicDAO.findById(product).get().setUrl(url);
		Optional<Music> music = musicDAO.findById(product);
		session.setAttribute("music", music);
		List<Music> musics = (List<Music>)musicDAO.findAll();
		session.setAttribute("musics", musics);
		return new ModelAndView("music");
	}
}
