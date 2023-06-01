
import Foundation

struct Current: Codable {

  var lastUpdatedEpoch : Int?       = nil
  var lastUpdated      : String?    = nil
  var tempC            : Int?       = nil
  var tempF            : Int?       = nil
  var isDay            : Int?       = nil
  var condition        : Condition? = Condition()
  var windMph          : Double?    = nil
  var windKph          : Int?       = nil
  var windDegree       : Int?       = nil
  var windDir          : String?    = nil
  var pressureMb       : Int?       = nil
  var pressureIn       : Double?    = nil
  var precipMm         : Int?       = nil
  var precipIn         : Int?       = nil
  var humidity         : Int?       = nil
  var cloud            : Int?       = nil
  var feelslikeC       : Double?    = nil
  var feelslikeF       : Double?    = nil
  var visKm            : Int?       = nil
  var visMiles         : Int?       = nil
  var uv               : Int?       = nil
  var gustMph          : Double?    = nil
  var gustKph          : Double?    = nil

  enum CodingKeys: String, CodingKey {

    case lastUpdatedEpoch = "last_updated_epoch"
    case lastUpdated      = "last_updated"
    case tempC            = "temp_c"
    case tempF            = "temp_f"
    case isDay            = "is_day"
    case condition        = "condition"
    case windMph          = "wind_mph"
    case windKph          = "wind_kph"
    case windDegree       = "wind_degree"
    case windDir          = "wind_dir"
    case pressureMb       = "pressure_mb"
    case pressureIn       = "pressure_in"
    case precipMm         = "precip_mm"
    case precipIn         = "precip_in"
    case humidity         = "humidity"
    case cloud            = "cloud"
    case feelslikeC       = "feelslike_c"
    case feelslikeF       = "feelslike_f"
    case visKm            = "vis_km"
    case visMiles         = "vis_miles"
    case uv               = "uv"
    case gustMph          = "gust_mph"
    case gustKph          = "gust_kph"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    lastUpdatedEpoch = try values.decodeIfPresent(Int.self       , forKey: .lastUpdatedEpoch )
    lastUpdated      = try values.decodeIfPresent(String.self    , forKey: .lastUpdated      )
    tempC            = try values.decodeIfPresent(Int.self       , forKey: .tempC            )
    tempF            = try values.decodeIfPresent(Int.self       , forKey: .tempF            )
    isDay            = try values.decodeIfPresent(Int.self       , forKey: .isDay            )
    condition        = try values.decodeIfPresent(Condition.self , forKey: .condition        )
    windMph          = try values.decodeIfPresent(Double.self    , forKey: .windMph          )
    windKph          = try values.decodeIfPresent(Int.self       , forKey: .windKph          )
    windDegree       = try values.decodeIfPresent(Int.self       , forKey: .windDegree       )
    windDir          = try values.decodeIfPresent(String.self    , forKey: .windDir          )
    pressureMb       = try values.decodeIfPresent(Int.self       , forKey: .pressureMb       )
    pressureIn       = try values.decodeIfPresent(Double.self    , forKey: .pressureIn       )
    precipMm         = try values.decodeIfPresent(Int.self       , forKey: .precipMm         )
    precipIn         = try values.decodeIfPresent(Int.self       , forKey: .precipIn         )
    humidity         = try values.decodeIfPresent(Int.self       , forKey: .humidity         )
    cloud            = try values.decodeIfPresent(Int.self       , forKey: .cloud            )
    feelslikeC       = try values.decodeIfPresent(Double.self    , forKey: .feelslikeC       )
    feelslikeF       = try values.decodeIfPresent(Double.self    , forKey: .feelslikeF       )
    visKm            = try values.decodeIfPresent(Int.self       , forKey: .visKm            )
    visMiles         = try values.decodeIfPresent(Int.self       , forKey: .visMiles         )
    uv               = try values.decodeIfPresent(Int.self       , forKey: .uv               )
    gustMph          = try values.decodeIfPresent(Double.self    , forKey: .gustMph          )
    gustKph          = try values.decodeIfPresent(Double.self    , forKey: .gustKph          )
 
  }

  init() {

  }

}