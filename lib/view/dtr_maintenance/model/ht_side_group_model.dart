class HtSideGroupModel {
  bool abSwitchAvailable;
  AbSwitchType? abSwitchType;
  Status? abSwitchStatus;
  int contactsDamagedQty;
  int brassStripsDamagedQty;
  int nylonBushDamagedQty;

  bool hgFuseSet11KvAvailable;
  Status? hgFuseStatus;
  int hornsToBeReplacedQty;
  bool gapIsNotCorrect;
  int postTypeInsulatorsDamagedQty;

  Status? htBushesStatus;
  int htBushDamagedQty;

  Status? htBushRodsStatus;
  int htBushRodsDamagedQty;

  HtSideGroupModel({
    required this.abSwitchAvailable,
    this.abSwitchType,
    this.abSwitchStatus,
    required this.contactsDamagedQty,
    required this.brassStripsDamagedQty,
    required this.nylonBushDamagedQty,
    required this.hgFuseSet11KvAvailable,
    this.hgFuseStatus,
    required this.hornsToBeReplacedQty,
    required this.gapIsNotCorrect,
    required this.postTypeInsulatorsDamagedQty,
    this.htBushesStatus,
    required this.htBushDamagedQty,
    this.htBushRodsStatus,
    required this.htBushRodsDamagedQty,
  });

  factory HtSideGroupModel.fromJson(Map<String, dynamic> json) {
    return HtSideGroupModel(
      abSwitchAvailable: json['abSwitchAvailable'] ?? false,
      abSwitchType: AbSwitchType.values.firstWhere(
            (e) => e.toString() == 'ABSwitchType.${json['abSwitchType']}',
        orElse: () => AbSwitchType.Vertical, // Provide a default value
      ),
      abSwitchStatus: Status.values.firstWhere(
            (e) => e.toString() == 'Status.${json['abSwitchStatus']}',
        orElse: () => Status.Good, // Provide a default value
      ),
      contactsDamagedQty: json['contactsDamagedQty'] ?? 0,
      brassStripsDamagedQty: json['brassStripsDamagedQty'] ?? 0,
      nylonBushDamagedQty: json['nylonBushDamagedQty'] ?? 0,
      hgFuseSet11KvAvailable: json['hgFuseSet11KvAvailable'] ?? false,
      hgFuseStatus: Status.values.firstWhere(
            (e) => e.toString() == 'Status.${json['hgFuseStatus']}',
        orElse: () => Status.Good,
      ),
      hornsToBeReplacedQty: json['hornsToBeReplacedQty'] ?? 0,
      gapIsNotCorrect: json['gapIsNotCorrect'] ?? false,
      postTypeInsulatorsDamagedQty: json['postTypeInsulatorsDamagedQty'] ?? 0,
      htBushesStatus: Status.values.firstWhere(
            (e) => e.toString() == 'Status.${json['htBushesStatus']}',
        orElse: () => Status.Good,
      ),
      htBushDamagedQty: json['htBushDamagedQty'] ?? 0,
      htBushRodsStatus: Status.values.firstWhere(
            (e) => e.toString() == 'Status.${json['htBushRodsStatus']}',
        orElse: () => Status.Good,
      ),
      htBushRodsDamagedQty: json['htBushRodsDamagedQty'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abSwitchAvailable': abSwitchAvailable,
      'abSwitchType': abSwitchType?.toString().split('.').last,
      'abSwitchStatus': abSwitchStatus?.toString().split('.').last,
      'contactsDamagedQty': contactsDamagedQty,
      'brassStripsDamagedQty': brassStripsDamagedQty,
      'nylonBushDamagedQty': nylonBushDamagedQty,
      'hgFuseSet11KvAvailable': hgFuseSet11KvAvailable,
      'hgFuseStatus': hgFuseStatus?.toString().split('.').last,
      'hornsToBeReplacedQty': hornsToBeReplacedQty,
      'gapIsNotCorrect': gapIsNotCorrect,
      'postTypeInsulatorsDamagedQty': postTypeInsulatorsDamagedQty,
      'htBushesStatus': htBushesStatus?.toString().split('.').last,
      'htBushDamagedQty': htBushDamagedQty,
      'htBushRodsStatus': htBushRodsStatus?.toString().split('.').last,
      'htBushRodsDamagedQty': htBushRodsDamagedQty,
    };
  }

  @override
  String toString() {
    return '''
    HtSideGroupModel(
      abSwitchAvailable: $abSwitchAvailable,
      abSwitchType: $abSwitchType,
      abSwitchStatus: $abSwitchStatus,
      contactsDamagedQty: $contactsDamagedQty,
      brassStripsDamagedQty: $brassStripsDamagedQty,
      nylonBushDamagedQty: $nylonBushDamagedQty,
      hgFuseSet11KvAvailable: $hgFuseSet11KvAvailable,
      hgFuseStatus: $hgFuseStatus,
      hornsToBeReplacedQty: $hornsToBeReplacedQty,
      gapIsNotCorrect: $gapIsNotCorrect,
      postTypeInsulatorsDamagedQty: $postTypeInsulatorsDamagedQty,
      htBushesStatus: $htBushesStatus,
      htBushDamagedQty: $htBushDamagedQty,
      htBushRodsStatus: $htBushRodsStatus,
      htBushRodsDamagedQty: $htBushRodsDamagedQty
    )
    ''';
  }
}

enum Status { Good, Damaged,Ok,Replaced,Not_Rectified,Rectified }
enum AbSwitch { Available, NotAvailable }
enum AbSwitchType { Vertical, Horizontal }
enum WireStatus{OK, NotOK}
enum FuseWire {Copper, Aluminium, Strands}
enum OilLevel {Ok, Shortage}
enum OilLeak {LeakedArrested, NotRectified}
enum Gaskets {Rectified_Replaced, NotRectified, Rectified}
enum EarthPits {one, two,three}
enum EarthPipes {GIPipes, CIPipes}
enum NoLooseLine{NoLooseLines, LooseLines}
enum LTLineTreeCutting{NotRequired, Required}
enum DTROverLoaded {NotOverLoaded, OverLoaded}
