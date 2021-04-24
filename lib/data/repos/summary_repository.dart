// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:summarator/common/errors/bad_request.dart';
import 'package:summarator/common/errors/failure.dart';
import 'package:summarator/common/errors/no_connection.dart';
import 'package:summarator/common/utils/logger.dart';
import 'package:summarator/common/utils/network_check.dart';
import 'package:summarator/domain/repos/summary_repository.dart';

@LazySingleton(as: ISummaryRepository)
class SummaryRepository implements ISummaryRepository {
  final NetworkCheck networkCheck;
  final Dio dio;

  SummaryRepository({required this.networkCheck, required this.dio});
  @override
  Future<Either<Failure, String>> getSummary(
      {required Map<String, dynamic> payload}) async {
    try {
      if (await networkCheck.isOnline()) {
        final result = await dio.post('http://192.168.43.221:8080', data: {
          "text":
              "The global Business Intelligence (BI) market grew by 10% in 2013 according to the Gartner Re- port. Today organizations require better use of data and analytics to support their business deci- sions. Internet power and business trend changes have provided a broad term for data analytics – Big Data. To be able to handle it and leverage a value of having access to Big Data, organizations have no other choice than to get proper systems implemented and working. However traditional methods are not efficient for changing business needs. The long time between project start and go-live causes a gap between initial solution blueprint and actual user requirements in the end of the project. This article presents the latest market trends in BI systems implementation by com- paring Agile with traditional methods. It presents a case study provided in a large telecommunica- tions company (20K employees) and the results of a pilot research provided in the three large companies: telecommunications, digital, and insurance. Both studies prove that Agile methods might be more effective in BI projects from an end-user perspective and give first results and added value in a much shorter time compared to a traditional approach. BI complexity and changing requirements represent the most difficult challenges facing applica- tions. During the process of BI implementation multiple components must be considered from the very start such as data integration, cleansing, modelling, warehousing, metrics creation and man- agement, reports, dashboards, queries, alerts, and many more (Cerqueira, 2015). This requires a clear vision of future needs and a very well defined strategy from project sponsors and end-users. Projects take a long time to implement and their effects can be visible sometimes only after a few years (Kernochan, 2011). Today organizations require BI solu- tions more than they needed them in previous years and decades. Due to rap- id market changes, organizations need to adapt to the new environment properly if they do not want to stay behind their competitors. This situation impacts us- ers’ requirements for data and reports. Thus BI projects final products are often found useless due to organizational needs that have changed during the time of project design and implementation (Eckerson, 2007a, 2007b; Marjanovic, 2011). Business cannot longer afford empty investments and needs to have quick benefits and an acceptable payback on the selected BI technology (Oxford Economics, 2015). Traditional methods of BI implementation are no longer efficient. An overly lengthy timeline, the inability to request timely changes that usually occur only at the end of the project, and overly complex approaches do not allow meeting customer targets (Vijaya, 2013). Agile methods brought a new view to a project delivery. It proves that success can be achieved more quickly by delivery of actual product in iteration. In this article effectiveness is measured from the added value brought by BI in a short time (less than 6 months), namely return on investment achieved after the first BI benefits appear and by meeting end-users’ requirements. This article presents some initial research in order to answer the question, “Is Agile more efficient in BI implementation compared to traditional methods?”.Currently, Business Intelligence systems are the most required systems in the market. However, organizations continue to struggle with the decision to implement them in their environment. Changing markets and big data insight forces organizations to react quickly, especially due to growing competition. However, to meet customer’s requirements, BI methods of implementation need to change from a traditional waterfall method to an Agile approach. The study in this article presents the benefits of Agile methods especially in the area of user’s constant involvement and delivery in iterations. Today business cannot wait long for the first results of a system’s imple- mentation. It can be achieved only thanks to a few main critical factors: Easy adaptability to changes when required, Frequent functionalities delivery, Fast ROI, Easy and cost-effective maintenance after BI implementation. The Agile approach provides methods and techniques to meet these above factors. As the case study and surveys show, end-users find BI more valuable when it is implemented using the Agile method. It helps to achieve the goal and effective BI implementation. It helps to provide not only reliable data and good analysis but at the same time to optimize the process and increase added value. The presented study is based on few companies, similar in terms of company size and type. Thus, it will be followed will be followed by further research, which will be published in materials available at the Warsaw University of Technology.",
          "useClustering": true
        });
        return Right(result.data['result']);
      }
      return Left(NoConnectionError());
    } catch (e) {
      Log.e('getSummary ERROR: $e');
      return Left(BadRequest());
    }
  }
}
