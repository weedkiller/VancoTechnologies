using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Dispatcher;

namespace GreenNub
{
    public class HttpNotFoundAwareDefaultHttpControllerSelector : DefaultHttpControllerSelector
    {

        public HttpNotFoundAwareDefaultHttpControllerSelector(HttpConfiguration configuration)
        : base(configuration)
        {
        }
        public override HttpControllerDescriptor SelectController(HttpRequestMessage request)
        {
            HttpControllerDescriptor decriptor = null;
            try
            {
                decriptor = base.SelectController(request);
            }
            catch (HttpResponseException ex)
            {
                string clientAddress = HttpContext.Current.Request.UserHostAddress;
                var code = ex.Response.StatusCode;
                if (code != HttpStatusCode.NotFound)
                    throw;
                var routeValues = request.GetRouteData().Values;
                routeValues["controller"] = "Error";
               routeValues["action"] = "Handle404";

                decriptor = base.SelectController(request);
            }
            //if (request.RequestUri.AbsolutePath.ToString() = "")
            //{
            //    return null;
            //}
            return decriptor;
        }
    }
}