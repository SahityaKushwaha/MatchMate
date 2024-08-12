

import Foundation
struct Results : Decodable {
	var gender : String?
    var name : Name?
    var location : Location?
    var email : String?
    var login : Login?
    var dob : Dob?
    var registered : Registered?
    var phone : String?
    var cell : String?
    var id : Id?
    var picture : Picture?
    var nat : String?
    var status: String?

	enum CodingKeys: String, CodingKey {

		case gender = "gender"
		case name = "name"
		case location = "location"
		case email = "email"
		case login = "login"
		case dob = "dob"
		case registered = "registered"
		case phone = "phone"
		case cell = "cell"
		case id = "id"
		case picture = "picture"
		case nat = "nat"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		name = try values.decodeIfPresent(Name.self, forKey: .name)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		login = try values.decodeIfPresent(Login.self, forKey: .login)
		dob = try values.decodeIfPresent(Dob.self, forKey: .dob)
		registered = try values.decodeIfPresent(Registered.self, forKey: .registered)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		cell = try values.decodeIfPresent(String.self, forKey: .cell)
		id = try values.decodeIfPresent(Id.self, forKey: .id)
		picture = try values.decodeIfPresent(Picture.self, forKey: .picture)
		nat = try values.decodeIfPresent(String.self, forKey: .nat)
	}
    
    // Custom initializer for mock data
        init(
            gender: String? = nil,
            name: Name? = nil,
            location: Location? = nil,
            email: String? = nil,
            login: Login? = nil,
            dob: Dob? = nil,
            registered: Registered? = nil,
            phone: String? = nil,
            cell: String? = nil,
            id: Id? = nil,
            picture: Picture? = nil,
            nat: String? = nil,
            status: String? = nil
        ) {
            self.gender = gender
            self.name = name
            self.location = location
            self.email = email
            self.login = login
            self.dob = dob
            self.registered = registered
            self.phone = phone
            self.cell = cell
            self.id = id
            self.picture = picture
            self.nat = nat
            self.status = status
        }
}
