//
//  NasaExoplanet.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 13/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

struct NasaExoplanet : APIManager {
    
    static var baseURL: String = "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=exomultpars&select=mpl_name,mpl_reflink,mpl_discmethod,mpl_mnum,mpl_pnum,mpl_orbper,mpl_orbtper,mpl_bmassj,mpl_bmasse,mpl_radj,mpl_rade,mpl_rads,mpl_dens,dec,mpl_status,mpl_disc,mpl_publ_date,rowupdate,hd_name,hip_name,mst_age,mst_mass,mst_rad,mst_logg,mst_lum,mst_dens,mst_teff,mst_metfe,mst_metratio&format=json"
    static var key: String?
    
    public static func getExoplanetExtendedData(_ completion: @escaping ([Exoplanet]) -> Void) {
        GET.request(NasaExoplanet.baseURL) { data in
            do {
                let exoplanets = try JSONDecoder().decode([Exoplanet].self, from: data)
                completion(exoplanets)
            } catch {
                print("There was a JSON parse error. Error description: \(error.localizedDescription) - \(error)")
            }
        }
    }
    
}
